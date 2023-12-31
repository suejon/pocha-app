import 'dart:async';
import 'dart:io';

import 'package:mime/mime.dart';
import 'package:new_mac_test/models/media.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;
var uuid = const Uuid();

Future<String?> getMimeType(File file) async {
  var raf = await file.open(mode: FileMode.read);
  var headerBytes = await raf.read(16);
  await raf.close();
  return lookupMimeType(file.path, headerBytes: headerBytes);
}

Future<Media> getMediaById(String id) async {
  var res = await supabase.from('media').select().eq('id', id).single();
  return Media.fromJson(res);
}

Future<List<Media>> getMediaByStore(String storeId) async {
  var res = await supabase.from('media').select().eq('store_id', storeId);
  return Media.listFromJson(res);
}

Future<String> uploadMedia(String storeId, File file) async {
  var mimeType = await getMimeType(file);

  if (mimeType == null) {
    print('No mime type found');
    throw Exception('No mime type found');
  }

  var mimeStart = mimeType.split('/').first;
  String? type;
  if (mimeStart == 'image') {
    type = 'image';
  } else if (type == 'video') {
    type = 'video';
  }

  if (type == null) {
    print('Unsupported mime type: $mimeType');
    throw Exception('Unsupported file type');
  }

  var id = uuid.v4();
  var key = await supabase.storage.from('media').upload('$storeId/$id', file);

  await supabase.from('media').insert([
    {
      'store_id': storeId,
      'ref': key,
      'type': type,
      'mime_type': mimeType,
    }
  ]);

  return key;
}
