import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_clean_architecture/core/strings/success_messages.dart';

import '../../../../../core/failures.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_event.dart';

part 'add_delete_update_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddDeleteUpdatePostBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdatePostState());
      if (event is AddPostEvent) {
        final successOrFailureToAddPost = await addPostUseCase(event.post);
        emit(_getSuccessOrFailureMessage(
            successOrFailureToAddPost, ADD_POST_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        final successOrFailureToAddPost = await updatePostUseCase(event.post);
        emit(_getSuccessOrFailureMessage(
            successOrFailureToAddPost, UPDATE_POST_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        final successOrFailureToAddPost = await deletePostUseCase(event.postId);
        emit(_getSuccessOrFailureMessage(
            successOrFailureToAddPost, DELETE_POST_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _getSuccessOrFailureMessage(
      Either<Failure, Unit> failureOrSuccess, String successMessage) {
    return failureOrSuccess.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
            message: _mapFailureToMessage(failure)),
        (unit) => MessageAddDeleteUpdatePostState(message: successMessage));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
