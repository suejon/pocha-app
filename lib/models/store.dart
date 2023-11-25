import 'package:new_mac_test/models/category.dart';
import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/media.dart';

class Store {
  String? id;

  String? name;

  String? createdAt;

  String? updatedAt;

  Store({this.name});

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
    return {'name': name};
  }

  static List<Store> listFromJson(List<dynamic> json) {
    return json.map((value) => Store.fromJson(value)).toList();
  }
}

class StoreWithDetails extends Store {
  List<Location> locations = [];
  List<Media> media = [];
  List<Category> categories = [];

  StoreWithDetails();

  @override
  String toString() {
    final locs = locations.toString();
    final med = media.toString();
    final cats = categories.toString();
    return 'Store[id=$id, name=$name, createdAt=$createdAt, updatedAt=$updatedAt, locations=$locs, media=$med, categories=$cats]';
  }

  StoreWithDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locations =
        json['location'] != null ? Location.listFromJson(json['location']) : [];
    media = json['media'] != null ? Media.listFromJson(json['media']) : [];
    categories =
        json['category'] != null ? Category.listFromJson(json['category']) : [];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'locations': locations,
      'media': media,
      'categories': categories
    };
  }

  static List<StoreWithDetails> listFromJson(List<dynamic> json) {
    return json.map((value) => StoreWithDetails.fromJson(value)).toList();
  }
}
