class Comment {
  String? id;

  String? comment;

  String? userId;

  String? storeId;

  String? replyToId;

  String? createdAt;

  String? updatedAt;

  String? deletedAt;

  Comment();

  @override
  String toString() {
    return 'Comment{id: $id, comment: $comment, userId: $userId, storeId: $storeId, replyToId: $replyToId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
  }

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userId = json['user_id'];
    storeId = json['store_id'];
    replyToId = json['reply_to_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'user_id': userId,
      'store_id': storeId,
      'reply_to_id': replyToId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  static List<Comment> listFromJson(List<dynamic> json) {
    return json.map((value) => Comment.fromJson(value)).toList();
  }
}
