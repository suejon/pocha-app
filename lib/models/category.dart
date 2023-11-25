part of swagger.api;

class Category {
  /* Note: This is a Primary Key.<pk/> */
  int id = null;

  String name = null;

  String createdAt = "now()";

  Category();

  @override
  String toString() {
    return 'Category[id=$id, name=$name, createdAt=$createdAt, ]';
  }

  Category.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt
     };
  }

  static List<Category> listFromJson(List<dynamic> json) {
    return json == null ? new List<Category>() : json.map((value) => new Category.fromJson(value)).toList();
  }

  static Map<String, Category> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Category>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Category.fromJson(value));
    }
    return map;
  }
}
