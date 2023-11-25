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
