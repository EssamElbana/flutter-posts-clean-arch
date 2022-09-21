part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdatePostState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}