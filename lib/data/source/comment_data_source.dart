import 'package:dio/dio.dart';
import 'package:nike_2/data/comment.dart';
import 'package:nike_2/data/common/http_validate_respnse.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll(int productId);
}

class CommentRemoteDataSource
    with HttpValidateRespnse
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource({required this.httpClient});
  @override
  Future<List<CommentEntity>> getAll(int productId) async {
    final response =
        await httpClient.get('/comment/list?product_id=$productId');
    validateResponse(response);
    final List<CommentEntity> comments = [];
    (response as List).forEach((element) {
      comments.add(CommentEntity.fromjson(element));
    });
    return comments;
  }
}
