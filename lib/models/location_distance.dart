class LocationDistance {
  String? id;

  double? latitude;

  double? longitude;

  double? distance;

  String? storeId;

  LocationDistance();

  @override
  String toString() {
    return 'LocationDistance[id=$id, latitude=$latitude, longitude=$longitude, distance=$distance, storeId=$storeId, ]';
  }

  LocationDistance.fromJson(Map<String, dynamic> json) {
    id = json['location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['dist_meters'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': id,
      'latitude': latitude,
      'longitude': longitude,
      'dist_meters': distance,
      'store_id': storeId,
    };
  }

  static List<LocationDistance> listFromJson(List<dynamic> json) {
    return json.map((value) => LocationDistance.fromJson(value)).toList();
  }
}
