import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<bool> getStores(int atomicNumber) async {
  return  await supabase
  .from('store')
  .select();
}

