import 'package:new_mac_test/models/visit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<Visit> createVisit(Visit visit) async {
  final response = await supabase.from('visit').insert(visit.toJson());
  if (response.error != null) {
    throw response.error!;
  }
  return visit;
}
