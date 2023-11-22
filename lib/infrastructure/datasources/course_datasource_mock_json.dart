import 'dart:convert';
import 'package:flutter/services.dart';

import '/domain/datasources/course_datasource.dart';
import '/domain/entities/course_entity.dart';
import '/infrastructure/mappers/course_mapper.dart';
import '/infrastructure/models/course_model.dart';

class CourseDatasourceMockJson implements CourseDatasource{
  @override
  Future<List<CourseEntity>> getAllCourses() async {
    String jsonString = await rootBundle.loadString('assets/data/mock_data.json');
    final jsonResponse = json.decode(jsonString);
    return CourseMapper.toListGoalEntity(jsonResponse.map<CourseModel>((item) => CourseModel.fromJson(item)).toList());
  }
  
}