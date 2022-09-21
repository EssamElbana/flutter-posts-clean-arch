import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';

import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
      return await repository.getAllPosts();
  }
}
