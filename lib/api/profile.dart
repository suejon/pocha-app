import 'package:new_mac_test/models/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unique_name_generator/unique_name_generator.dart';

final supabase = Supabase.instance.client;
final ung = UniqueNameGenerator(
  dictionaries: [adjectives, animals],
  style: NameStyle.capital,
  separator: '_',
);

String generateUsername() {
  return ung.generate();
}

Future<void> createProfile(String id) async {
  var username = generateUsername();

  var res = await supabase.from('profile').insert([
    {
      'id': id,
      'username': username,
    }
  ]);

  if (res.error != null) {
    throw Exception(res.error!.message);
  }
}

Future<void> updateProfile(String id, String username) async {
  var res = await supabase.from('profile').update({
    'username': username,
  }).eq('id', id);

  if (res.error != null) {
    throw Exception(res.error!.message);
  }
}

Future<Profile> getProfile(String id) async {
  var res = await supabase.from('profile').select().eq('id', id).single();

  return Profile.fromJson(res.data);
}
