import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/common/colors.dart';
import 'package:getxstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:getxstudentrecorderhive/common/widget/delete_widget.dart';
import 'package:getxstudentrecorderhive/controller/home_controller.dart';
import 'package:getxstudentrecorderhive/view/add_student.dart';
import 'package:getxstudentrecorderhive/view/edit_student.dart';
import 'package:getxstudentrecorderhive/view/search_student.dart';
import 'package:getxstudentrecorderhive/view/view_student.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final student = Get.put(StudentController());
    return Scaffold(
      appBar: CustomAppBar(
        title: "Student Record",
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchStudent());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Obx(
        () => student.students.isEmpty
            ? const Center(
                child: Text(
                  "No Data, Please Add",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                itemCount: student.students.length,
                itemBuilder: (context, index) {
                  final studentData = student.students[index];

                  return Card(
                    color: Colors.blueGrey[100],
                    elevation: 5,
                    child: ListTile(
                      onTap: () => Get.to(
                        () => ViewStudent(
                          studentId: studentData.key,
                        ),
                      ),
                      title: Text(
                        studentData.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          File(studentData.image),
                        ),
                      ),
                      subtitle: Text(
                        studentData.domain,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.to(() => EditStudent(data: studentData));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                            IconButton(
                                onPressed: () {
                                  delete(studentData.name, studentData.key);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[600],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.appBGColor,
        foregroundColor: AppColor.appFGColor,
        onPressed: () {
          Get.to(() => const AddStudent());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
