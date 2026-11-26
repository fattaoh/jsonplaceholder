import 'package:flutter/material.dart';
import 'package:jsonplaceholder/service/api_services.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/post_widget.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView(
      onFetch: ApiService.fetchPosts,
      itemBuilder: (context, post, index) {
        return PostWidget(post: post);
      },
      searchText: (post) => '${post.title} ${post.body} ${post.userId}',
      title: 'Posts',
    );
  }
}