import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universe/data/models/post.dart';

class HomeWebServices {
  HomeWebServices();

  Future<List<QueryDocumentSnapshot>> getAllPosts() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection("posts").get();
    List<QueryDocumentSnapshot> postsList = querySnapshot.docs;
    return postsList;
  }

  Future<List<QueryDocumentSnapshot>> getLikedPosts() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .where("isLiked", isEqualTo: true)
        .get();
    List<QueryDocumentSnapshot> postsList = querySnapshot.docs;
    return postsList;
  }

  Future<List<QueryDocumentSnapshot>> getSavedPosts() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("posts")
        .where("isSaved", isEqualTo: true)
        .get();
    List<QueryDocumentSnapshot> postsList = querySnapshot.docs;
    return postsList;
  }

  addPost(Post post) async {
    await FirebaseFirestore.instance.collection("posts").add({
      "description": post.description,
      "image": post.image,
      "isLiked": post.isLiked,
      "isSaved": post.isSaved,
      "userID": FirebaseAuth.instance.currentUser?.uid,
    });
  }

  updatePost(Post post) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(post.docID)
        .update({
      "description": post.description,
      "image": post.image,
      "isLiked": post.isLiked,
      "isSaved": post.isSaved,
      "userID": FirebaseAuth.instance.currentUser?.uid,
    });
  }
}
