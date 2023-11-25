import 'package:new_mac_test/models/location.dart';
import 'package:new_mac_test/models/media.dart';

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

class StoreWithDetails extends Store {
  List<Location> locations = [];
  List<Media> media = [];

  StoreWithDetails();

  @override
  String toString() {
    final locs = locations.toString();
    final med = media.toString();
    return 'Store[id=$id, name=$name, createdAt=$createdAt, updatedAt=$updatedAt, locations=$locs, media=$med]';
  }

  StoreWithDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locations =
        json['location'] != null ? Location.listFromJson(json['location']) : [];
    media = json['media'] != null ? Media.listFromJson(json['media']) : [];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'locations': locations,
      'media': media
    };
  }

  static List<StoreWithDetails> listFromJson(List<dynamic> json) {
    return json.map((value) => StoreWithDetails.fromJson(value)).toList();
  }
}
