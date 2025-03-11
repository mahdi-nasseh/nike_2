import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nike_2/data/repo/comment_repository.dart';
import 'package:nike_2/ui/product/comment/bloc/comment_list_bloc.dart';
import 'package:nike_2/ui/product/comment/comment.dart';
import 'package:nike_2/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<CommentListBloc>(
      create: (context) {
        final bloc = CommentListBloc(
            productId: productId, repository: commentRepository);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentItem(
                    comment: state.comments[index],
                  );
                },
              ),
            );
          } else if (state is CommentListError) {
            return SliverToBoxAdapter(
              child: AppExceptionWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<CommentListBloc>(context)
                      .add(CommentListStarted());
                },
              ),
            );
          } else if (state is CommentListLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: LoadingAnimationWidget.bouncingBall(
                    color: themeData.colorScheme.primary, size: 20),
              ),
            );
          } else {
            throw Exception('commnts state is not valid');
          }
        },
      ),
    );
  }
}
