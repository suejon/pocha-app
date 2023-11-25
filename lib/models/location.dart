part of swagger.api;

class Location {
  /* Note: This is a Primary Key.<pk/> */
  String id = null;

  double latitude = null;

  double longitude = null;
/* Note: This is a Foreign Key to `store.id`.<fk table='store' column='id'/> */
  String storeId = null;

  String createdAt = "now()";

  String updatedAt = "now()";

  String geoloc = null;

  Location();

  @override
  String toString() {
    return 'Location[id=$id, latitude=$latitude, longitude=$longitude, storeId=$storeId, createdAt=$createdAt, updatedAt=$updatedAt, geoloc=$geoloc, ]';
  }

  Location.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
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
    return json == null ? new List<Location>() : json.map((value) => new Location.fromJson(value)).toList();
  }

  static Map<String, Location> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Location>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Location.fromJson(value));
    }
    return map;
  }
}
