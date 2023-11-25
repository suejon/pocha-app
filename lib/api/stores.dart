import 'package:new_mac_test/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Store>> getStores() async {
  List<Map<String, dynamic>> res = await supabase.from('store').select();

  return Store.listFromJson(res);
}
