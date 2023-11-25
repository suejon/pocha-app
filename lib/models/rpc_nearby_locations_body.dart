class RpcNearbyLocationsBody {
  double myLatitude = null;

  double myLongitude = null;

  RpcNearbyLocationsBody();

  @override
  String toString() {
    return 'RpcNearbyLocationsBody[myLatitude=$myLatitude, myLongitude=$myLongitude, ]';
  }

  RpcNearbyLocationsBody.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    myLatitude = json['my_latitude'];
    myLongitude = json['my_longitude'];
  }

  Map<String, dynamic> toJson() {
    return {'my_latitude': myLatitude, 'my_longitude': myLongitude};
  }

  static List<RpcNearbyLocationsBody> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RpcNearbyLocationsBody>()
        : json
            .map((value) => new RpcNearbyLocationsBody.fromJson(value))
            .toList();
  }

  static Map<String, RpcNearbyLocationsBody> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcNearbyLocationsBody>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RpcNearbyLocationsBody.fromJson(value));
    }
    return map;
  }
}
