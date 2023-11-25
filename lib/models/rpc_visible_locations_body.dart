class RpcVisibleLocationsBody {
  double xMax = null;

  double xMin = null;

  double yMax = null;

  double yMin = null;

  RpcVisibleLocationsBody();

  @override
  String toString() {
    return 'RpcVisibleLocationsBody[xMax=$xMax, xMin=$xMin, yMax=$yMax, yMin=$yMin, ]';
  }

  RpcVisibleLocationsBody.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    xMax = json['x_max'];
    xMin = json['x_min'];
    yMax = json['y_max'];
    yMin = json['y_min'];
  }

  Map<String, dynamic> toJson() {
    return {'x_max': xMax, 'x_min': xMin, 'y_max': yMax, 'y_min': yMin};
  }

  static List<RpcVisibleLocationsBody> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<RpcVisibleLocationsBody>()
        : json
            .map((value) => new RpcVisibleLocationsBody.fromJson(value))
            .toList();
  }

  static Map<String, RpcVisibleLocationsBody> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RpcVisibleLocationsBody>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new RpcVisibleLocationsBody.fromJson(value));
    }
    return map;
  }
}
