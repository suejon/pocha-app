import 'dart:io';

import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

final supabase = Supabase.instance.client;

Future<String?> getMimeType(File file) async {
  var raf = await file.open(mode: FileMode.read);
  var headerBytes = await raf.read(16);
  await raf.close();
  return lookupMimeType(file.path, headerBytes: headerBytes);
}

Future getMediaById(String id) async {
  return await supabase.from('media').select().eq('id', id);
}

Future getMediaByStore(String storeId) async {
  return await supabase.from('media').select().eq('store_id', storeId);
}

Future uploadMedia(String storeId, File file) async {
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

  const uuid = Uuid();

  var key =
      await supabase.storage.from('media').upload('$storeId/$uuid>', file);

  await supabase.from('media').insert([
    {
      'store_id': storeId,
      'ref': key,
      'uuid': uuid,
      'type': type,
      'mime_type': mimeType,
    }
  ]);

  return key;
}
