class Profile {
  String? id;

  String? nickname;

  bool? active;

  String? createdAt;

  String? updatedAt;

  @override
  String toString() {
    return 'Profile[id=$id, nickname=$nickname, active=$active, createdAt=$createdAt, updatedAt=$updatedAt, ]';
  }

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'active': active,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  static List<Profile> listFromJson(List<dynamic> json) {
    return json.map((value) => Profile.fromJson(value)).toList();
  }
}
