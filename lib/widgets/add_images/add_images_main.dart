import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controllers/add_image_controller.dart';
import 'package:student_getx/widgets/add_images/bottom_sheet.dart';

class AddImagesMain extends StatelessWidget {

  AddImagesMain({
    super.key,
  });

  final AddImageController controller = Get.put(AddImageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: (){
          Get.bottomSheet(MyBottomSheet());
        },
        child: controller.image.isNotEmpty
            ? SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(
                        controller.image.toString(),
                      ),
                      fit: BoxFit.cover,
                    )),
              )
            : Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey)),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.black12,
                      size: 80,
                    ),
                    Text(
                      'Add Image Here',
                      style: TextStyle(
                          color: Colors.black12,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
