class Location {
  String? id;

  double? latitude;

  double? longitude;

  String? storeId;

  String? createdAt;

  String? updatedAt;

  String? geoloc;

  String? displayAddress;

  String? userId;

  Location();

  @override
  String toString() {
    return 'Location[id=$id, latitude=$latitude, longitude=$longitude, storeId=$storeId, createdAt=$createdAt, updatedAt=$updatedAt, geoloc=$geoloc, displayAddress=$displayAddress, userId=$userId, ]';
  }

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    geoloc = json['geoloc'];
    displayAddress = json['display_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'store_id': storeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'geoloc': geoloc,
      'display_name': displayAddress,
      'user_id': userId,
    };
  }

  static List<Location> listFromJson(List<dynamic> json) {
    return json.map((value) => Location.fromJson(value)).toList();
  }
}
