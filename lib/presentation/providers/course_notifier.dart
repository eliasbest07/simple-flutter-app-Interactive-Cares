import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_flutter_application_interactive_cares/infrastructure/datasources/course_datasource_mock_json.dart';
import 'package:simple_flutter_application_interactive_cares/infrastructure/repositories/course_repository_impl.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';

class CourseNotifier extends StateNotifier<List<CourseEntity>> {

  CourseNotifier() : super([]) {
    init();
  }

  void init() async {
    CourseRepository courseRepository =
        CourseRepositoryImpl(courseDatasource: CourseDatasourceMockJson());
    state = await courseRepository.getAllCourses();
  
  }
}
