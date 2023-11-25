import 'package:new_mac_test/models/bookmark.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Bookmark>> getBookmarks() async {
  final res = await supabase.from('bookmark').select('''
    id,
    name,
    created_at,
    user_id,
    ''').order('created_at', ascending: false);

  return Bookmark.listFromJson(res);
}

Future<Bookmark> createBookmark(Bookmark bookmark) async {
  final response = await supabase.from('bookmark').insert(bookmark.toJson());
  if (response.error != null) {
    throw response.error!;
  }
  return bookmark;
}

Future<void> deleteBookmark(String id) async {
  final response = await supabase.from('bookmark').delete().eq('id', id);
  if (response.error != null) {
    throw response.error!;
  }
}
