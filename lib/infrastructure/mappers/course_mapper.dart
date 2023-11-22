import '/domain/entities/course_entity.dart';
import '/infrastructure/mappers/bookmark_mapper.dart';
import '/infrastructure/models/course_model.dart';

class CourseMapper {
  
  static List<CourseEntity> toListGoalEntity(List<CourseModel> list) {
    return list.map((e) => CourseMapper.toCourseEntity(e)).toList();
  }

  static CourseEntity toCourseEntity( CourseModel courseModel) => CourseEntity(
    bookmarks: BookmarkMapper.toListBookmarkEntity( courseModel.bookmarks),
    modules: courseModel.modules,
    percentageCompleted: courseModel.percentageCompleted,
    title: courseModel.title,
    videosUrl: courseModel.videosUrl
  );
}