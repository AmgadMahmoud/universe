import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/repository/home_repository.dart';

part 'saved_posts_state.dart';

class SavedPostsCubit extends Cubit<SavedPostsState> {
  final HomeRepository homeRepository;
  List<Map> posts = [];

  SavedPostsCubit(this.homeRepository) : super(SavedPostsInitial());

  getSavedPosts() async {
    emit(SavedPostsLoading());

    await homeRepository.getSavedPosts().then((postsObject) async {
      if (postsObject.isNotEmpty) {
        for (var element in postsObject) {
          posts.add({
            "description": element["description"],
            "isLiked": element["isLiked"],
            "isSaved": element["isSaved"],
            "images": element["image"],
          });
        }
        emit(SavedPostsLoaded(posts));
      } else {
        emit(SavedPostsEmpty());
      }
    });
  }
}
