class Store {
  String? id;

  String? name;

  String? createdAt;

  String? updatedAt;

  Store();

  @override
  String toString() {
    return 'Store[id=$id, name=$name, createdAt=$createdAt, updatedAt=$updatedAt, ]';
  }

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  static List<Store> listFromJson(List<dynamic> json) {
    return json.map((value) => Store.fromJson(value)).toList();
  }
}
