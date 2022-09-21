part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateEvent extends Equatable {}


class AddPostEvent extends AddDeleteUpdateEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdateEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdateEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}

