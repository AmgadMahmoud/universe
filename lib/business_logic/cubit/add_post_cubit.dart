import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/models/post.dart';
import 'package:universe/data/repository/home_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final HomeRepository homeRepository;

  AddPostCubit(this.homeRepository) : super(AddPostInitial());

  Future<String> addPost(Post post) async {
    String returnValue = "";
    emit(AddPostLoading());

    await homeRepository.addPost(post).then((addPostObject) async {
      returnValue = addPostObject;
      if (addPostObject == "success") {
        emit(AddPostCompleted());
      } else {
        emit(AddPostError());
      }
    });
    return returnValue;
  }
}
