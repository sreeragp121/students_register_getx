import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controllers/student_data_controller.dart';
import 'package:student_getx/views/edit_student/edit_student_main.dart';

class GridViewScreen extends StatelessWidget {
  GridViewScreen({super.key});
  final StudentDataController studentController =Get.find();
      

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final studentlist = studentController.studentData;
      return (studentlist.isEmpty)
          ? const Center(
              child: Text('Add Student'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9),
                itemBuilder: (ctx, index) {
                  final data = studentlist[index];
                  if (studentlist.isEmpty) {
                    return const Center(
                      child: Text(
                        'List is empty',
                        style: TextStyle(color: Colors.amber),
                      ),
                    );
                  }
                  return Card(
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  File(data.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              data.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Text(data.age),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.to(()=>EditStudent(index: index, studentData: data));
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                  iconSize: 20,
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
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  Get.snackbar(
                                                    'Deleted',
                                                    'Student details has been deleted',
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                    duration: const Duration(
                                                        seconds: 2),
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
                                  icon: const Icon(Icons.delete_outline),
                                  color: Colors.red,
                                  iconSize: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                  );
                },
                itemCount: studentlist.length,
              ),
            );
    });
  }
}
