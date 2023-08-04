import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/model.dart';

// ignore: non_constant_identifier_names
ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
List<StudentModel> studentSearchResults = [];

Future<void> addStudentDetailsToDatabase(StudentModel value) async {
  // ignore: non_constant_identifier_names
  final StudentDB = await Hive.openBox<StudentModel>('box');
  await StudentDB.add(value);
  studentListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudentDetailsFromDatabase() async {
  // ignore: non_constant_identifier_names
  final StudentDB = await Hive.openBox<StudentModel>('box');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(StudentDB.values);
  studentSearchResults.addAll(StudentDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudentDetailsFromDatabase(int id) async {
  // ignore: non_constant_identifier_names
  final StudentDB = await Hive.openBox<StudentModel>('box');
  await StudentDB.delete(id);
  getAllStudentDetailsFromDatabase();
}

Future<void> updateStudentDetailsInDatabase(StudentModel value, int id) async {
  // ignore: non_constant_identifier_names
  final StudentDB = await Hive.openBox<StudentModel>('box');
  StudentDB.put(id, value);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
  value.edited = true;
  getAllStudentDetailsFromDatabase();
}
