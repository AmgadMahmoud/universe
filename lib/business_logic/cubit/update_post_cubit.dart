import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:universe/data/models/post.dart';
import 'package:universe/data/repository/home_repository.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  final HomeRepository homeRepository;

  UpdatePostCubit(this.homeRepository) : super(UpdatePostInitial());

  Future<String> updatePost(Post post) async {
    String returnValue = "";
    emit(UpdatePostLoading());

    await homeRepository.updatePost(post).then((updatePostObject) async {
      returnValue = updatePostObject;
      if (updatePostObject == "success") {
        emit(UpdatePostCompleted());
      } else {
        emit(UpdatePostError());
      }
    });
    return returnValue;
  }
}
