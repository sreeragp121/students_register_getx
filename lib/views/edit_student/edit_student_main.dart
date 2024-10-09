import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controllers/add_image_controller.dart';
import 'package:student_getx/controllers/student_data_controller.dart';
import 'package:student_getx/models/student_model.dart';
import 'package:student_getx/widgets/add_images/add_images_main.dart';
import 'package:student_getx/widgets/my_text_form_field.dart';

class EditStudent extends StatelessWidget {
  final int index;
  final StudentModel studentData;
  final TextEditingController namecontroller;
  final TextEditingController agecontroller;
  final TextEditingController phoneNocontroller;
  final _formKey=GlobalKey<FormState>();
  final AddImageController imageController = Get.put(AddImageController());
  final StudentDataController studentDataController =
      Get.put(StudentDataController());
  EditStudent({super.key, required this.index, required this.studentData})
      : namecontroller = TextEditingController(text: studentData.name),
        agecontroller = TextEditingController(text: studentData.age),
        phoneNocontroller =
            TextEditingController(text: studentData.phoneNumber) {
    imageController.image.value = studentData.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        foregroundColor: Colors.black45,
        title: const Text('Add Student Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AddImagesMain(),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFormField(
                    controllers: namecontroller,
                    labelText: '*Name',
                    hintText: 'Student Name',
                    keyboardType: TextInputType.text,
                  ),
                  MyTextFormField(
                    controllers: agecontroller,
                    labelText: '*Age',
                    hintText: 'Student Age',
                    inputLength: 2,
                    keyboardType: TextInputType.number,
                  ),
                  MyTextFormField(
                    controllers: phoneNocontroller,
                    labelText: '*Phone Number',
                    hintText: 'Phone Number',
                    inputLength: 10,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState?.validate()?? false){
                        studentDataController.editStudentData(
                          index: index,
                          name: namecontroller.text,
                          age: agecontroller.text,
                          phoneNumber: phoneNocontroller.text,
                          imagepath: imageController.image.toString(),
                        );
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Get.snackbar(
                            'Success',
                            'Student details Edited successfully!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                          );
                        });
                        Get.back();
                      }
                      },
                      child: const Text('submit'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
