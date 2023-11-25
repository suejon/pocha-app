import 'package:new_mac_test/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<Store> getStores(int atomicNumber) async {
  return await supabase.from('store').select();
}
