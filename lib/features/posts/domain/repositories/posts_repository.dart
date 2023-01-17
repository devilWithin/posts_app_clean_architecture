import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

import '../../../../core/error/failure.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, Unit>> updatePost(Post newPost);
}
