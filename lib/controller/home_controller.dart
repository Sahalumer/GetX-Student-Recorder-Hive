import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/model/db_model.dart';
import 'package:hive/hive.dart';

class StudentController extends GetxController {
  RxList<Student> students = <Student>[].obs;
  final studentbox = Hive.box<Student>('students');

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  getStudents() async {
    final box = await Hive.openBox<Student>('students');
    students.assignAll(box.values.toList());
    box.watch().listen((event) {
      students.assignAll(box.values.toList());
    });
  }

  postStudent(Student data) async {
    await studentbox.add(data);
    Get.snackbar("Succes", "${data.name} Added succesfully");
  }

  updateStudent(Student data, int id) async {
    await studentbox.put(id, data);
    Get.snackbar("Succes", "${data.name} Updated succesfully");
  }

  Student? getStudentById(int id) {
    return students.firstWhereOrNull((student) => student.key == id);
  }

  deleteStudent(int id, String name) async {
    await studentbox.delete(id);
    Get.snackbar("Succes", "$name Deleted succesfully");
  }
}
