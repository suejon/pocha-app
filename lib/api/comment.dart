import 'package:new_mac_test/models/comment.dart';
import 'package:new_mac_test/models/comment_node.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Comment>> getTopLevelComments(String storeId, int offset, int limit) async {
  final res = await supabase
      .from('comment')
      .select(
          'id, comment, store_id, user_id, reply_to_id, created_at, updated_at, deleted_at')
      .eq('store_id', storeId)
      .is_('reply_to_id', null)
      .is_('deleted_at', null)
      .order('created_at', ascending: false)
      .limit(limit)
      .range(offset, offset + limit - 1);

  return Comment.listFromJson(res);
}

Future<List<Comment>> getCommentTree(
    int depthLimit, List<String> storeIds) async {
  final res = await supabase.rpc('get_comment_tree',
      params: {'depth_limit': depthLimit, 'store_ids': storeIds});

  return Comment.listFromJson(res);
}

Future<List<CommentNode>> getCommentsForStore(String storeId, int depth, int offset, int limit) async {
  final topLevelComments = await getTopLevelComments(storeId, offset, limit);
  if (topLevelComments.isEmpty) {
    return [];
  }

  List<String> storeIds = topLevelComments.map((e) => e.storeId!).toList();
  List<Comment> commentTree = await getCommentTree(depth, storeIds);

  List<CommentNode> comments = [];
  Map<String, CommentNode> commentMap = {};
  for (var comment in commentTree) {
    commentMap[comment.id!] = CommentNode(comment);
  }

  for (var comment in commentTree) {
    if (comment.replyToId == null) {
      comments.add(commentMap[comment.id!]!);
    } else {
      commentMap[comment.replyToId!]!.replies!.add(commentMap[comment.id!]!);
    }
  }

  return comments;
}

Future<void> addComment(String storeId, String comment, String? replyToId) async {
  var res = await supabase.from('comment').insert( {
    'comment': comment,
    'store_id': storeId,
    'reply_to_id': replyToId,
  });

  if (res.error != null) {
    throw Exception(res.error!.message);
  }
}
