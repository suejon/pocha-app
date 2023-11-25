class Location {
  String? id;

  double? latitude;

  double? longitude;

  String? storeId;

  String? createdAt;

  String? updatedAt;

  String? geoloc;

  Location();

  @override
  String toString() {
    return 'Location[id=$id, latitude=$latitude, longitude=$longitude, storeId=$storeId, createdAt=$createdAt, updatedAt=$updatedAt, geoloc=$geoloc, ]';
  }

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    geoloc = json['geoloc'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'store_id': storeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'geoloc': geoloc
    };
  }

  static List<Location> listFromJson(List<dynamic> json) {
    return json.map((value) => Location.fromJson(value)).toList();
  }
}
