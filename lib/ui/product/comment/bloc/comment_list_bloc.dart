import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/comment.dart';
import 'package:nike_2/data/repo/comment_repository.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final int productId;
  final ICommentRepository repository;
  CommentListBloc({required this.productId, required this.repository})
      : super(CommentListLoading()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        try {
          emit(CommentListLoading());
          final comments = await repository.getAll(productId);
          emit(CommentListSuccess(comments: comments));
        } catch (e) {
          emit(CommentListError(exception: AppException()));
        }
      }
    });
  }
}
