// facebook.com => baseURL (const)
//  facebook.com/posts => baseURL + posts (const)

import 'dart:convert';

import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/model/comments.dart';
import 'package:jsonplaceholder/model/photos.dart';
import 'package:jsonplaceholder/model/posts.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder/model/todos.dart';
import 'package:jsonplaceholder/model/users.dart';

class ApiServices {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';

  // endpoint posts
  static Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Posts.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch posts (HTTP ${response.statusCode})');
    }
  }

  // endpoint albums
  static Future<List<Albums>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Albums.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch albums (HTTP ${response.statusCode})');
    }
  }

  // endpoint comments
  static Future<List<Comments>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comments.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch comments (HTTP ${response.statusCode})');
    }
  }

  // endpoint photos
  static Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photos.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch photos (HTTP ${response.statusCode})');
    }
  }

  // endpoint posts
  static Future<List<Todos>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Todos.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch todos (HTTP ${response.statusCode})');
    }
  }

  // endpoint users
  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Users.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch users (HTTP ${response.statusCode})');
    }
  }
}
