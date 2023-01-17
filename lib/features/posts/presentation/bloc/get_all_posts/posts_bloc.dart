import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/strings/failures.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/get_all_posts_use_case.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(
          _mapFailureOrPostToState(failureOrPosts),
        );
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(
          _mapFailureOrPostToState(failureOrPosts),
        );
      }
    });
  }

  PostsState _mapFailureOrPostToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(
              errorMsg: _mapFailureToMessage(failure),
            ),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return unknownProblemMessage;
    }
  }
}
