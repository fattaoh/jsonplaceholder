import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/photos.dart';

class PhotoWidget extends StatelessWidget {
  final String photoUrl;
  const PhotoWidget({super.key, required this.photoUrl, required Photos photos});
  

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}