class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
}
