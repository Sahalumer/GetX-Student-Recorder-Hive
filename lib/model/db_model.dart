import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String domain;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String phone;
  @HiveField(4)
  late String image;
}
