class Visit {
  int? id;

  String? userId;

  String? locationId;

  String? visitedAt;

  Visit({this.locationId, DateTime? visitedAt}) {
    this.visitedAt = visitedAt.toString();
  }

  @override
  String toString() {
    return 'Visit[id=$id, userId=$userId, locationId=$locationId, visitedAt=$visitedAt, ]';
  }

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    locationId = json['location_id'];
    visitedAt = json['visited_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'location_id': locationId,
      'visited_at': visitedAt
    };
  }

  static List<Visit> listFromJson(List<dynamic> json) {
    return json.map((value) => Visit.fromJson(value)).toList();
  }
}
