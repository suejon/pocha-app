import 'dart:ffi';

import 'package:new_mac_test/models/location.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Location>> getLocations() async {
  List<Map<String, dynamic>> res = await supabase.from('location').select();

  return Location.listFromJson(res);
}

Future<List<Location>> getVisibleLocations(
    Float xMin, Float yMin, Float xMax, Float yMax) async {
  final data = await supabase.rpc('visible_locations', params: {
    'x_min': xMin,
    'y_min': yMin,
    'x_max': xMax,
    'y_max': yMax,
  });

  List<Map<String, dynamic>> res = await supabase.from('location').select();

  // TODO: Get stores by id
  return Location.listFromJson(res);
}

Future<List<Location>> getNearbyLocations(
    Float latitude, Float longtitude) async {
  final data = await supabase.rpc('nearby_locations',
      params: {'my_latitude': latitude, 'my_longitude': longtitude});

  List<Map<String, dynamic>> res = await supabase.from('location').select();

  // TODO: Get stores by id
  return Location.listFromJson(res);
}

// TODO: remove if unused
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
