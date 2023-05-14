import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int status;
  String message;
  Body body;

  Post({
    required this.status,
    required this.message,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    status: json["status"],
    message: json["message"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "body": body.toJson(),
  };
}

class Body {
  List<PostElement> posts;

  Body({
    required this.posts,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    posts: List<PostElement>.from(json["posts"].map((x) => PostElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}

class PostElement {
  int id;
  String title;
  Member member;
  DateTime createdAt;
  DateTime updatedAt;

  PostElement({
    required this.id,
    required this.title,
    required this.member,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostElement.fromJson(Map<String, dynamic> json) => PostElement(
    id: json["id"],
    title: json["title"],
    member: Member.fromJson(json["member"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "member": member.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Member {
  int id;
  String nickName;

  Member({
    required this.id,
    required this.nickName,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    nickName: json["nickName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickName": nickName,
  };
}
