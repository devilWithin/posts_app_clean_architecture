import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostsRepository postsRepository;

  GetAllPostsUseCase({required this.postsRepository});

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
