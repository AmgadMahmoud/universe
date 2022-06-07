part of 'add_post_cubit.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostCompleted extends AddPostState {
  AddPostCompleted();
}

class AddPostLoading extends AddPostState {
  AddPostLoading();
}

class AddPostError extends AddPostState {
  AddPostError();
}
