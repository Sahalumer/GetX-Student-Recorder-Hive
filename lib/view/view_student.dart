import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:getxstudentrecorderhive/controller/home_controller.dart';
import 'package:getxstudentrecorderhive/view/edit_student.dart';

class ViewStudent extends StatelessWidget {
  final int studentId;
  const ViewStudent({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final student = studentController.getStudentById(studentId);

    if (student == null) {
      return const Scaffold(
        appBar: CustomAppBar(title: "Student Not Found"),
        body: Center(child: Text("Student not found")),
      );
    }

    return Obx(() {
      final updatedStudent = studentController.getStudentById(studentId);

      if (updatedStudent == null) {
        return const Scaffold(
          appBar: CustomAppBar(title: "Student Not Found"),
          body: Center(child: Text("Student not found")),
        );
      }

      return Scaffold(
        appBar: CustomAppBar(
          title: updatedStudent.name,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => EditStudent(data: updatedStudent));
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey.withOpacity(0.5),
                  child: Image.file(
                    File(updatedStudent.image),
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                updatedStudent.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.domain,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.email,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                updatedStudent.phone,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    });
  }
}
