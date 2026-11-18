import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/comments.dart';
import 'package:jsonplaceholder/service/api_services.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/comment_widget.dart';

class CommentsTab extends StatelessWidget {
  final Comments comments;
  const CommentsTab({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView(
      onFetch: ApiService.fetchComments,
      itemBuilder: (context, comments, index) {
        return CommentWidget(comments: comments);
      },
      title: 'Comments',
    );
  }
}
