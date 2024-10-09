import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controllers/student_data_controller.dart';
import 'package:student_getx/views/edit_student/edit_student_main.dart';

class ListViewHomePage extends StatelessWidget {
  ListViewHomePage({super.key});
  final StudentDataController studentController =Get.put(StudentDataController());
      

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final studentlist = studentController.studentData;
      return (studentlist.isEmpty)
          ? const Center(
              child: Text('Add Student'),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final data = studentlist[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      data.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(data.age),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                      radius: 30,
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.to(()=>EditStudent(index: index, studentData: data));
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        'Are you sure wanted to Delete'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          studentController.delete(
                                              index: index);
                                          Future.delayed(
                                              const Duration(milliseconds: 200),
                                              () {
                                            Get.snackbar(
                                              'Deleted',
                                              'Student details has been deleted',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              duration:
                                                  const Duration(seconds: 2),
                                            );
                                          });
                                          Get.back();
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('NO'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
              itemCount: studentlist.length,
            );
    });
  }
}
