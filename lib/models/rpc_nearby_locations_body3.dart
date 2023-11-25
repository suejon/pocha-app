part of swagger.api;

class RpcNearbyLocationsBody3 {
  
  double myLatitude = null;

  double myLongitude = null;

  RpcNearbyLocationsBody3();

  @override
  String toString() {
    return 'RpcNearbyLocationsBody3[myLatitude=$myLatitude, myLongitude=$myLongitude, ]';
  }

  RpcNearbyLocationsBody3.fromJson(Map<String, dynamic> json) {
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

  static List<RpcNearbyLocationsBody3> listFromJson(List<dynamic> json) {
    return json == null ? new List<RpcNearbyLocationsBody3>() : json.map((value) => new RpcNearbyLocationsBody3.fromJson(value)).toList();
  }

  static Map<String, RpcNearbyLocationsBody3> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcNearbyLocationsBody3>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RpcNearbyLocationsBody3.fromJson(value));
    }
    return map;
  }
}
