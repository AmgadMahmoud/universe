part of 'all_posts_cubit.dart';

@immutable
abstract class AllPostsState {}

class AllPostsInitial extends AllPostsState {}

class AllPostsLoaded extends AllPostsState {
  final List<Map> posts;

  AllPostsLoaded(this.posts);
}

class AllPostsLoading extends AllPostsState {
  AllPostsLoading();
}

class AllPostsError extends AllPostsState {
  AllPostsError();
}

class AllPostsEmpty extends AllPostsState {
  AllPostsEmpty();
}
