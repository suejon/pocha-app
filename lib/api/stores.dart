import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Store>> getStores() async {
  final res = await supabase.from('store').select();

  return Store.listFromJson(res);
}

Future<Store> getStore(String id) async {
  return await supabase.from('store').select().eq('id', id).single();
}

Future<Store> createStore(Store store) async {
  final response = await supabase.from('store').insert(store.toJson());
  if (response.error != null) {
    throw response.error!;
  }
  return store;
}

Future<Store> updateStore(Store store) async {
  final response =
      await supabase.from('store').update(store.toJson()).eq('id', store.id);
  if (response.error != null) {
    throw response.error!;
  }
  return store;
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
