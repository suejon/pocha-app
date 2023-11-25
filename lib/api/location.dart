import 'dart:convert';
import 'dart:ffi';

import 'package:new_mac_test/models/address.dart';
import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/location_distance.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

final supabase = Supabase.instance.client;

Future<List<Location>> getLocations() async {
  List<Map<String, dynamic>> res = await supabase.from('location').select();

  return Location.listFromJson(res);
}

Future<List<Location>> getVisibleLocations(
    Float xMin, Float yMin, Float xMax, Float yMax) async {
  var res = await supabase.rpc('visible_locations', params: {
    'x_min': xMin,
    'y_min': yMin,
    'x_max': xMax,
    'y_max': yMax,
  });

  return Location.listFromJson(res);
}

Future<List<LocationDistance>> getNearbyLocations(
    Float latitude, Float longtitude) async {
  var res = await supabase.rpc('nearby_locations',
      params: {'my_latitude': latitude, 'my_longitude': longtitude});

  return LocationDistance.listFromJson(res);
}

Future<List<Location>> getLocationsForStore(String storeId) async {
  final res = await supabase
      .from('location')
      .select()
      .eq('store_id', storeId)
      .order('created_at', ascending: false);

  return Location.listFromJson(res);
}

Future<Location> createLocationForStore(
    String storeId, Location location) async {
  if (location.latitude == null || location.longitude == null) {
    throw Exception('Latitude and longitude are required');
  }

  var address = await getAddress(location.latitude!, location.longitude!);
  location.displayAddress = address.displayName;

  final response = await supabase.from('location').insert(location.toJson());
  if (response.error != null) {
    throw response.error!;
  }

  return location;
}

Future<ExternalAddress> getAddress(double lat, double long) async {
  var url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$long&accept-language=en&format=json');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    return ExternalAddress.fromJson(body);
  } else {
    throw Exception('Failed to load address');
  }
}
