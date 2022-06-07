import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/repository/home_repository.dart';

part 'liked_posts_state.dart';

class LikedPostsCubit extends Cubit<LikedPostsState> {
  final HomeRepository homeRepository;
  List<Map> posts = [];

  LikedPostsCubit(this.homeRepository) : super(LikedPostsInitial());

  getLikedPosts() async {
    emit(LikedPostsLoading());

    await homeRepository.getLikedPosts().then((postsObject) async {
      if (postsObject.isNotEmpty) {
        for (var element in postsObject) {
          posts.add({
            "description": element["description"],
            "isLiked": element["isLiked"],
            "isSaved": element["isSaved"],
            "images": element["image"],
          });
        }
        emit(LikedPostsLoaded(posts));
      } else {
        emit(LikedPostsEmpty());
      }
    });
  }
}
