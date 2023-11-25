class Media {
  String? id;

  String? ref;

  String? createdAt;

  String? updatedAt;

  String? deletedAt;

  String? storeId;

  String? type;

  String? mimeType;

  Media();

  @override
  String toString() {
    return 'Media[id=$id, ref=$ref, createdAt=$createdAt, updatedAt=$updatedAt, deletedAt=$deletedAt, storeId=$storeId, type=$type, mime_type=$mimeType, ]';
  }

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ref = json['ref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    storeId = json['store_id'];
    type = json['type'];
    mimeType = json['mime_type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ref': ref,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'store_id': storeId,
      'type': type,
      'mime_type': mimeType,
    };
  }

  static List<Media> listFromJson(List<dynamic> json) {
    return json.map((value) => Media.fromJson(value)).toList();
  }
}
