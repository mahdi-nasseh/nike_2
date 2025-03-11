import 'package:flutter/material.dart';
import 'package:nike_2/data/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [Text(comment.title), Text(comment.email)],
                ),
                Text(comment.date),
              ],
            ),
            Text(comment.content)
          ],
        ),
      ),
    );
  }
}
