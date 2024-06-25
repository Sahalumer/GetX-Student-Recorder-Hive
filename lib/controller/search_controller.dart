import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/model/db_model.dart';
import 'package:hive/hive.dart';

class SearchControllerStudent extends GetxController {
  RxList<Student> results = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStudents();
  }

  getStudents() async {
    final box = await Hive.openBox<Student>('students');
    results.assignAll(box.values.toList());
  }

  search(String query) {
    if (query.isEmpty) {
      getStudents();
    } else {
      results.value = results
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
