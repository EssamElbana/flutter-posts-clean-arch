import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';

import '../../../../core/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  PostRepository postRepository;

  UpdatePostUseCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return postRepository.updatePost(post);
  }
}
