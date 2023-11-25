import 'package:new_mac_test/models/comment.dart';

class CommentNode {
  String? id;

  String? comment;

  String? userId;

  String? storeId;

  List<CommentNode>? replies;

  String? createdAt;

  String? updatedAt;

  CommentNode(Comment value) {
    id = value.id;
    comment = value.comment;
    userId = value.userId;
    storeId = value.storeId;
    createdAt = value.createdAt;
    updatedAt = value.updatedAt;
    replies = [];
  }
}
