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

  static Map<String, Store> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Store>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Store.fromJson(value));
    }
    return map;
  }
}
