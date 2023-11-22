class BookmarkModel {
  String videoUrl = '';
  String title = '';
  int segunds = 0;

  BookmarkModel({required this.title, required this.videoUrl, required this.segunds});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      title: json['title'],
      segunds: json['segunds'],
      videoUrl:json['videoUrl']
    );
  }
}