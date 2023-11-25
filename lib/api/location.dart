import 'dart:ffi';

import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/location_distance.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Location>> getLocations() async {
  List<Map<String, dynamic>> res = await supabase.from('location').select();

  return Location.listFromJson(res);
}

Future<List<Location>> getVisibleLocations(
    double xMin, double yMin, double xMax, double yMax) async {
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
  final response = await supabase.from('location').insert(location.toJson());
  if (response.error != null) {
    throw response.error!;
  }

  return location;
}
