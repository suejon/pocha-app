part of swagger.api;

class RpcNearbyLocationsBody2 {
  
  double myLatitude = null;

  double myLongitude = null;

  RpcNearbyLocationsBody2();

  @override
  String toString() {
    return 'RpcNearbyLocationsBody2[myLatitude=$myLatitude, myLongitude=$myLongitude, ]';
  }

  RpcNearbyLocationsBody2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    myLatitude = json['my_latitude'];
    myLongitude = json['my_longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'my_latitude': myLatitude,
      'my_longitude': myLongitude
     };
  }

  static List<RpcNearbyLocationsBody2> listFromJson(List<dynamic> json) {
    return json == null ? new List<RpcNearbyLocationsBody2>() : json.map((value) => new RpcNearbyLocationsBody2.fromJson(value)).toList();
  }

  static Map<String, RpcNearbyLocationsBody2> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcNearbyLocationsBody2>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RpcNearbyLocationsBody2.fromJson(value));
    }
    return map;
  }
}
