import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/features/posts/domain/repositories/posts_repositories.dart';

import '../../../../core/failures.dart';

class DeletePostUseCase {
  final PostRepository postRepository;

  DeletePostUseCase({required this.postRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return postRepository.deletePost(postId);
  }
}
