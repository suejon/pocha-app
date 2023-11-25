import 'package:new_mac_test/models/category.dart';
import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/media.dart';
import 'package:new_mac_test/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<StoreWithDetails>> getStores() async {
  // NOTE: if more than one relationship is found between tableA-B, you need to use explicit syntax to indicate the correct fk e.g. location!location_store_id_fkey(*),
  final res = await supabase.from('store').select('''
    id,
    name,
    created_at,
    updated_at,
    location(*),
    media(*)
    ''');
  return StoreWithDetails.listFromJson(res);
}

Future<(Store, Location, Media, List<Category>)> getStore(String id) async {
  final store = await supabase.from('store').select().eq('id', id).single();
  final location = await supabase
      .from('location')
      .select()
      .eq('store_id', id)
      .order('created_at')
      .single();
  final pic =
      await supabase.from('media').select().order('created_at').single();
  final categories = await supabase
      .from('category')
      .select('*, store_category(*)')
      .eq('store_category.store_id', id)
      .order('created_at');
  return (
    Store.fromJson(store),
    Location.fromJson(location),
    Media.fromJson(pic),
    Category.listFromJson(categories),
  );
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
