import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/albums_tab.dart';
import 'package:jsonplaceholder/pages/tabs/comments_tab.dart';
import 'package:jsonplaceholder/pages/tabs/photos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';
import 'package:jsonplaceholder/pages/tabs/todos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/users_tab.dart';


class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('JSONPlaceholder'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              const Tab(text: 'Posts', icon: Icon(Icons.message)),
              const Tab(text: 'Comments', icon: Icon(Icons.comment)),
              const Tab(text: 'Albums', icon: Icon(Icons.photo_album)),
              const Tab(text: 'Photos', icon: Icon(Icons.photo)),
              const Tab(text: 'Todos', icon: Icon(Icons.checklist)),
              const Tab(text: 'Users', icon: Icon(Icons.person)),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            PostsTab(),
            CommentsTab(),
            AlbumsTab(),
            PhotosTab(),
            TodosTab(),
            UsersTab(),
          ],
        ),
      ),
    );
  }
}