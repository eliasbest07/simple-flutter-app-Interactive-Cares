import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/domain/entities/course_entity.dart';
import '/presentation/screens/screens.dart';

final appRouter = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => FirebaseAuth.instance.currentUser == null ? const HomeScreen() : const DashboardScreen() ),
      
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
