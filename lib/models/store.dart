import 'package:new_mac_test/models/location.dart';

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

class StoreWithLocation extends Store {
  List<Location> locations = [];

  StoreWithLocation();

  @override
  String toString() {
    final locs = locations.toString();
    return 'Store[id=$id, name=$name, createdAt=$createdAt, updatedAt=$updatedAt, locations=$locs ]';
  }

  StoreWithLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locations =
        json['location'] != null ? Location.listFromJson(json['location']) : [];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'locations': locations
    };
  }

  static List<StoreWithLocation> listFromJson(List<dynamic> json) {
    return json.map((value) => StoreWithLocation.fromJson(value)).toList();
  }
}
