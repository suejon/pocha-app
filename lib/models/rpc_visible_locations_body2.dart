class RpcVisibleLocationsBody2 {
  double xMax = null;

  double xMin = null;

  double yMax = null;

  double yMin = null;

  RpcVisibleLocationsBody2();

  @override
  String toString() {
    return 'RpcVisibleLocationsBody2[xMax=$xMax, xMin=$xMin, yMax=$yMax, yMin=$yMin, ]';
  }

  RpcVisibleLocationsBody2.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    xMax = json['x_max'];
    xMin = json['x_min'];
    yMax = json['y_max'];
    yMin = json['y_min'];
  }

  Map<String, dynamic> toJson() {
    return {'x_max': xMax, 'x_min': xMin, 'y_max': yMax, 'y_min': yMin};
  }

  static List<RpcVisibleLocationsBody2> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RpcVisibleLocationsBody2>()
        : json
            .map((value) => new RpcVisibleLocationsBody2.fromJson(value))
            .toList();
  }

  static Map<String, RpcVisibleLocationsBody2> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcVisibleLocationsBody2>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RpcVisibleLocationsBody2.fromJson(value));
    }
    return map;
  }
}
