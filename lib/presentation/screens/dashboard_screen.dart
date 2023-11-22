import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_flutter_application_interactive_cares/domain/entities/course_entity.dart';

import '../providers/riverpod_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(coursesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            context.pop();
          }
        ),
      ),
      body: Column(
        children: [
          const Text('Your courses:',style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
              return _CourseTile(courses: courses, index:index); 
              })
            )
          ]
        ),
    );
  }
}

class _CourseTile extends ConsumerWidget {
  const _CourseTile({
    required this.courses, 
    required this.index,
  });

  final List<CourseEntity> courses;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionTile(
      title:  Text(courses[index].title, overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 20)),
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Percentage completed'),
              SizedBox(
                width: 50,
                height: 50,
                child: Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        value: courses[index].percentageCompleted,
                      ),
                    ),
                    Center(
                      child: Text('${(courses[index].percentageCompleted *100).toInt()}%', style: const TextStyle(fontSize: 12),))
                  ],
                ),
              ),
            ]
          ),
          subtitle: MaterialButton(
            color: Theme.of(context).primaryColor,
            onPressed: (){
              ref.read(videoIdProvider.notifier).update((state) => courses[index].videosUrl.first);
              for (var _ in courses[index].modules) {
                ref.read(moduleDone.notifier).update((state) { 
                  state.add(false);
                  return state;});  
              }
              context.push('/dashboard/course', extra: courses[index]);
            },
            child: const Text('Continue', style: TextStyle(color: Colors.white),),
            ),
        )]
      );
  }
}
