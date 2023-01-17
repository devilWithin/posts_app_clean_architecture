import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failure.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;

  DeletePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return postsRepository.deletePost(postId);
  }
}
