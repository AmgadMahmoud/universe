part of 'liked_posts_cubit.dart';

@immutable
abstract class LikedPostsState {}

class LikedPostsInitial extends LikedPostsState {}

class LikedPostsLoaded extends LikedPostsState {
  final List<Map> posts;

  LikedPostsLoaded(this.posts);
}

class LikedPostsLoading extends LikedPostsState {
  LikedPostsLoading();
}

class LikedPostsError extends LikedPostsState {
  LikedPostsError();
}

class LikedPostsEmpty extends LikedPostsState {
  LikedPostsEmpty();
}
