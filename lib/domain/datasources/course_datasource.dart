import '../entities/course_entity.dart';

abstract class CourseDatasource {
  Future<List<CourseEntity>> getAllCourses();
}
