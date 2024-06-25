import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:getxstudentrecorderhive/common/widget/custom_text_widget.dart';
import 'package:getxstudentrecorderhive/common/widget/save_button.dart';
import 'package:getxstudentrecorderhive/controller/home_controller.dart';
import 'package:getxstudentrecorderhive/controller/image_controller.dart';
import 'package:getxstudentrecorderhive/model/db_model.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _domainController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageController = Get.put(AddImageController());
  final StudentController studentclr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Student"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(
                () => InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      _imageController.selectedImage.value =
                          File(pickedFile.path);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey.withOpacity(.5),
                      child: _imageController.selectedImage.value != null
                          ? Image.file(_imageController.selectedImage.value!,
                              fit: BoxFit.cover)
                          : const Center(child: Icon(Icons.add_a_photo)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormWidget(
                labelText: "Name",
                hintText: "Enter Your Name",
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value) =>
                    value == null ? "Please Enter Your Name" : null,
              ),
              const SizedBox(height: 15),
              CustomTextFormWidget(
                labelText: "Domain",
                hintText: "Enter Your Domain",
                keyboardType: TextInputType.text,
                controller: _domainController,
                validator: (value) =>
                    value == null ? "Please Enter Your Domain" : null,
              ),
              const SizedBox(height: 15),
              CustomTextFormWidget(
                labelText: "Email",
                hintText: "Enter Your Email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null) {
                    return "Please Enter Your Email";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Please Enter a Valid Email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              CustomTextFormWidget(
                labelText: "Phone No",
                hintText: "Enter Your Phone Number",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.length != 10
                    ? "Please Enter the Phone Number"
                    : null,
              ),
              const SizedBox(height: 25),
              SaveButton(onPressed: saveButton)
            ],
          ),
        ),
      ),
    );
  }

  void saveButton() {
    if (_formKey.currentState!.validate()) {
      final student = Student();
      student.name = _nameController.text;
      student.domain = _domainController.text;
      student.email = _emailController.text;
      student.phone = _phoneController.text;
      student.image = _imageController.selectedImage.value!.path;
      studentclr.postStudent(student);
      Get.back();
    }
  }
}
