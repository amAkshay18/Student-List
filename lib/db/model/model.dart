import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String number;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final String imgpath;

  @HiveField(4)
  bool? edited;

  @HiveField(5)
  final String email;

  StudentModel(
      {required this.imgpath,
      required this.place,
      required this.name,
      required this.number,
      required this.email,
      this.edited});
}
