class PostSaveReqDTO {
  final String title;
  final String content;

  PostSaveReqDTO({
    required this.title,
    required this.content
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content
  };
}