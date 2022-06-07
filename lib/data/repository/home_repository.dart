import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe/data/models/post.dart';
import 'package:universe/data/web_services/home_web_services.dart';

class HomeRepository {
  final HomeWebServices homeWebServices;

  HomeRepository(this.homeWebServices);

  Future<List<QueryDocumentSnapshot>> getAllPosts() async {
    final getAllPostsData = await homeWebServices.getAllPosts();
    return getAllPostsData;
  }

  Future<List<QueryDocumentSnapshot>> getLikedPosts() async {
    final getLikedPostsData = await homeWebServices.getLikedPosts();
    return getLikedPostsData;
  }

  Future<List<QueryDocumentSnapshot>> getSavedPosts() async {
    final getSavedPostsData = await homeWebServices.getSavedPosts();
    return getSavedPostsData;
  }

  Future<String> addPost(Post post) async {
    final addPostData = await homeWebServices.addPost(post);
    return addPostData;
  }

  Future<String> updatePost(Post post) async {
    final updatePostData = await homeWebServices.updatePost(post);
    return updatePostData;
  }
}
