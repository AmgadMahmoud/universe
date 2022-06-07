part of 'update_post_cubit.dart';

@immutable
abstract class UpdatePostState {}

class UpdatePostInitial extends UpdatePostState {}

class UpdatePostCompleted extends UpdatePostState {
  UpdatePostCompleted();
}

class UpdatePostLoading extends UpdatePostState {
  UpdatePostLoading();
}

class UpdatePostError extends UpdatePostState {
  UpdatePostError();
}
