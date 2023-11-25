class Bookmark {
  String? id;
  String? storeId;
  String? userId;
  String? createdAt;

  Bookmark();

  Bookmark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'created_at': createdAt,
      'user_id': userId,
    };
  }

  static List<Bookmark> listFromJson(List<dynamic> json) {
    return json.map((value) => Bookmark.fromJson(value)).toList();
  }
}
