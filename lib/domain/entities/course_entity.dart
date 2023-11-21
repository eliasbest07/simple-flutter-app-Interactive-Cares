import '/domain/entities/bookmark_entity.dart';

class CourseEntity {
  String title = '';
  List<String> videosUrl = [];
  List<String> modules = [];
  List<BookmarkEntity> bookmarks = [];
  double percentageCompleted = 0;

  CourseEntity({
    required this.title,
    required this.videosUrl,
    required this.modules,
    required this.bookmarks,
    required this.percentageCompleted,
  });
}
