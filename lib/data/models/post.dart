const String tablePosts = 'posts_table';

class PostsFields {
  static final List<String> values = [
    id,
    columnDocID,
    columnDescription,
    columnIsLiked,
    columnIsSaved,
    columnImage
  ];

  static const String id = '_id';
  static const String columnDocID = 'docID';
  static const String columnDescription = 'description';
  static const String columnIsLiked = 'isLiked';
  static const String columnIsSaved = 'isSaved';
  static const String columnImage = 'image';
}

class Post {
  Post({
    required this.docID,
    required this.description,
    required this.isLiked,
    required this.isSaved,
    required this.image,
  });

  String docID;
  String description;
  bool isLiked;
  bool isSaved;
  String image;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    docID: json["docID"],
    description: json["description"],
    isLiked: json["isLiked"],
    isSaved: json["isSaved"],
    image: json["image"],
  );
}
