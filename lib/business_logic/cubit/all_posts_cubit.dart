import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/repository/home_repository.dart';

part 'all_posts_state.dart';

class AllPostsCubit extends Cubit<AllPostsState> {
  final HomeRepository homeRepository;
  List<Map> posts = [];

  AllPostsCubit(this.homeRepository) : super(AllPostsInitial());

  getAllPosts() async {
    emit(AllPostsLoading());

    await homeRepository.getAllPosts().then((postsObject) async {
      if (postsObject.isNotEmpty) {
        for (var element in postsObject) {
          posts.add({
            "docID": element.id,
            "description": element["description"],
            "isLiked": element["isLiked"],
            "isSaved": element["isSaved"],
            "images": element["image"],
          });
        }
        emit(AllPostsLoaded(posts));
      } else {
        emit(AllPostsEmpty());
      }
    });
  }
}
