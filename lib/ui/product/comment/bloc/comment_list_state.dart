part of 'comment_list_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListLoading extends CommentListState {}

class CommentListError extends CommentListState {
  final AppException exception;

  const CommentListError({required this.exception});
}

class CommentListSuccess extends CommentListState {
  final List<CommentEntity> comments;

  const CommentListSuccess({required this.comments});
}
