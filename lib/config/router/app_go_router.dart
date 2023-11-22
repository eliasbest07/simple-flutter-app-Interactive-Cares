import 'package:go_router/go_router.dart';
import 'package:simple_flutter_application_interactive_cares/domain/entities/course_entity.dart';

import '/presentation/screens/screens.dart';

final appRouter = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScree()),
      
      GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
          routes: [
            GoRoute(
              path: 'course',
              builder: (context, state) {
                final course = state.extra as CourseEntity;
                return CoursePlayerScreen(course: course,);
              },
            )
          ]),

    ]);
