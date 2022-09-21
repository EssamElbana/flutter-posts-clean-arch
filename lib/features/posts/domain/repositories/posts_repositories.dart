import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure,List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> deletePost(int postId);

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> addPost(Post post);
}
