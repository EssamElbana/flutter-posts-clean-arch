import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/exceptions.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';

import '../../domain/entities/post.dart';
import 'package:http/http.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts/"),
        headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200) {
      final List decodeJson = jsonDecode(response.body) as List;
      final List<PostModel> postModels = decodeJson.map<PostModel>((
          jsonPostModel) =>
          PostModel.fromJson(jsonPostModel)).toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body
    };
    final response = await client.post(
        Uri.parse("$BASE_URL/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse("$BASE_URL/posts/${postId.toString()}"));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body
    };
    final response = await client.patch(
        Uri.parse("$BASE_URL/posts/${postId.toString()}"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
