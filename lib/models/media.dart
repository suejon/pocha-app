class Media {
  /* Note: This is a Primary Key.<pk/> */
  String id = null;

  String ref = null;

  String createdAt = "now()";

  String updatedAt = "now()";

  String deletedAt = null;
/* Note: This is a Foreign Key to `store.id`.<fk table='store' column='id'/> */
  String storeId = null;

  Media();

  @override
  String toString() {
    return 'Media[id=$id, ref=$ref, createdAt=$createdAt, updatedAt=$updatedAt, deletedAt=$deletedAt, storeId=$storeId, ]';
  }

  Media.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    ref = json['ref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ref': ref,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'store_id': storeId
    };
  }

  static List<Media> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Media>()
        : json.map((value) => new Media.fromJson(value)).toList();
  }

  static Map<String, Media> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Media>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Media.fromJson(value));
    }
    return map;
  }
}
