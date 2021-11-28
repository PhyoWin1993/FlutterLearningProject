class PostList {
  final List<Post> posts;

  PostList({required this.posts});
  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts;
    posts = parsedJson.map((e) => Post.fromJson(e)).toList();
    return PostList(posts: posts);
  }
}

class Post {
  int userId;
  int id;
  String title, body;
  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body}); // naming parameter

  // List<Post> getData() => [
  //       Post(3, 3, "ksjf", "kdjfd"),
  //       Post(3, 3, "ksjf", "kdjfd"),
  //       Post(3, 3, "ksjf", "kdjfd"),
  //       Post(3, 3, "ksjf", "kdjfd"),
  //       Post(3, 3, "ksjf", "kdjfd"),
  //     ];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json["userId"],
        id: json['id'],
        title: json["title"],
        body: json['body']);
  }
}
