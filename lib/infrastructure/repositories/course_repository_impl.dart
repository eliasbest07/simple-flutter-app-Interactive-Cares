import '/domain/datasources/course_datasource.dart';
import '/domain/entities/course_entity.dart';
import '/domain/repositories/course_repository.dart';


class CourseRepositoryImpl implements CourseRepository {
  final CourseDatasource courseDatasource;

  CourseRepositoryImpl({required this.courseDatasource});
  @override
  Future<List<CourseEntity>> getAllCourses() async {
    return await courseDatasource.getAllCourses();
  }
}
