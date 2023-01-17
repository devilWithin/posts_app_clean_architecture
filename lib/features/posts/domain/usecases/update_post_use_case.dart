import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  final PostsRepository postsRepository;

  UpdatePostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Post newPost) async {
    return await postsRepository.updatePost(newPost);
  }
}
