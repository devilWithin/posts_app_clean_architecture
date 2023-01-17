import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/strings/success_messages.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/usecases/delete_posts_use_case.dart';
import 'package:posts_app/features/posts/domain/usecases/update_post_use_case.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  AddDeleteUpdatePostBloc({
    required this.addPostUseCase,
    required this.deletePostUseCase,
    required this.updatePostUseCase,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(
          LoadingAddDeleteUpdatePostState(),
        );
        final failOrDoneResponse = await addPostUseCase(event.post);
        emit(
          _successOrFailureState(
              either: failOrDoneResponse, messageType: addSuccessMessage),
        );
      } else if (event is UpdatePostEvent) {
        emit(
          LoadingAddDeleteUpdatePostState(),
        );
        final failOrDoneResponse = await updatePostUseCase(event.post);
        emit(
          _successOrFailureState(
              either: failOrDoneResponse, messageType: updateSuccessMessage),
        );
      } else if (event is DeletePostEvent) {
        emit(
          LoadingAddDeleteUpdatePostState(),
        );
        final failOrDoneResponse = await deletePostUseCase(event.postId);
        emit(
          _successOrFailureState(
              either: failOrDoneResponse, messageType: deleteSuccessMessage),
        );
      }
    });
  }

  AddDeleteUpdatePostState _successOrFailureState({
    required Either<Failure, Unit> either,
    required String messageType,
  }) {
    return either.fold(
      (failure) {
        return ErrorAddDeleteUpdatePostState(
          errorMessage: _mapFailureToMessage(failure),
        );
      },
      (_) {
        return SuccessAddDeleteUpdatePostState(
          successMessage: messageType,
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return unknownProblemMessage;
    }
  }
}
