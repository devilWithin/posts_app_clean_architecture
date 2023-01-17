import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;

  AddPostUseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postsRepository.addPost(post);
  }
}
