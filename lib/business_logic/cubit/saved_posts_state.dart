part of 'saved_posts_cubit.dart';

@immutable
abstract class SavedPostsState {}

class SavedPostsInitial extends SavedPostsState {}

class SavedPostsLoaded extends SavedPostsState {
  final List<Map> posts;

  SavedPostsLoaded(this.posts);
}

class SavedPostsLoading extends SavedPostsState {
  SavedPostsLoading();
}

class SavedPostsError extends SavedPostsState {
  SavedPostsError();
}

class SavedPostsEmpty extends SavedPostsState {
  SavedPostsEmpty();
}
