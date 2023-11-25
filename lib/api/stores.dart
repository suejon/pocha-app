import 'package:new_mac_test/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Store>> getStores() async {
  List<Map<String, dynamic>> res = await supabase.from('store').select();

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
