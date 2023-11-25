class Category {
  int? id;

  String? name;

  String? createdAt;

  Category();

  @override
  String toString() {
    return 'Category[id=$id, name=$name, createdAt=$createdAt, ]';
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'created_at': createdAt};
  }

  static List<Category> listFromJson(List<dynamic> json) {
    return json.map((value) => Category.fromJson(value)).toList();
  }

  static Map<String, Category> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Category>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new Category.fromJson(value));
    }
    return map;
  }
}
