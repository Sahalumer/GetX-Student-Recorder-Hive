import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/controller/search_controller.dart';
import 'package:getxstudentrecorderhive/view/view_student.dart';

class SearchStudent extends StatelessWidget {
  const SearchStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchControllerStudent());
    final textController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                onChanged: (value) => controller.search(value),
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.results.isEmpty
                    ? const Center(
                        child: Text("No Student Found"),
                      )
                    : ListView.builder(
                        itemCount: controller.results.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            onTap: () => Get.to(() => ViewStudent(
                                studentId: controller.results[index].key)),
                            title: Text(controller.results[index].name),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
