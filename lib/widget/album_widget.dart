import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/albums.dart';

class AlbumWidget extends StatelessWidget {
  final Albums albums;
  const AlbumWidget({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(albums.title),
            subtitle: Row(
              children: [
                Text('Album ID: ${albums.id}'),
                SizedBox(width: 10),
                Text('User ID: ${albums.userId}'),
              ],
            ),
          ),
        ],
      ),
    )
  }
}