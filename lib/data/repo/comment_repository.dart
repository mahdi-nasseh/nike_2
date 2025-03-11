import 'package:nike_2/common/http_client.dart';
import 'package:nike_2/data/comment.dart';
import 'package:nike_2/data/source/comment_data_source.dart';

final commentRepository = CommentRepository(
    dataSource: CommentRemoteDataSource(httpClient: httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll(int productId);
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});
  @override
  Future<List<CommentEntity>> getAll(int productId) =>
      dataSource.getAll(productId);
}
