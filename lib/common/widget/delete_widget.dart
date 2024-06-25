import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/controller/home_controller.dart';

delete(String name, int id) {
  Get.defaultDialog(
    title: "Delete Confirmation",
    middleText: 'Are you sure you want to delete this student?',
    textCancel: "Cancel",
    textConfirm: "Confirm",
    confirmTextColor: Colors.white,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      StudentController().deleteStudent(id, name);
      Get.back();
    },
  );
}
