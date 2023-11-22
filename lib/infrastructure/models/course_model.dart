import '/infrastructure/models/bookmark_model.dart';

class CourseModel {
  String title;
  List<String> videosUrl;
  List<String> modules;
  List<BookmarkModel> bookmarks;
  double percentageCompleted;

  CourseModel({
    required this.title,
    required this.videosUrl,
    required this.modules,
    required this.bookmarks,
    required this.percentageCompleted,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    var bookmarkList = json['bookmarks'] as List;
    List<BookmarkModel> bookmarkListItems = bookmarkList.map((i) => BookmarkModel.fromJson(i)).toList();

    return CourseModel(
      title: json['title'],
      videosUrl: List<String>.from(json['videosUrl']),
      modules: List<String>.from(json['modules']),
      bookmarks: bookmarkListItems,
      percentageCompleted: json['percentageCompleted'],
    );
  }
}