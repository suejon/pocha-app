class RpcNearbyLocationsBody1 {
  double myLatitude = null;

  double myLongitude = null;

  RpcNearbyLocationsBody1();

  @override
  String toString() {
    return 'RpcNearbyLocationsBody1[myLatitude=$myLatitude, myLongitude=$myLongitude, ]';
  }

  RpcNearbyLocationsBody1.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    myLatitude = json['my_latitude'];
    myLongitude = json['my_longitude'];
  }

  Map<String, dynamic> toJson() {
    return {'my_latitude': myLatitude, 'my_longitude': myLongitude};
  }

  static List<RpcNearbyLocationsBody1> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RpcNearbyLocationsBody1>()
        : json
            .map((value) => new RpcNearbyLocationsBody1.fromJson(value))
            .toList();
  }

  static Map<String, RpcNearbyLocationsBody1> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcNearbyLocationsBody1>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RpcNearbyLocationsBody1.fromJson(value));
    }
    return map;
  }
}
