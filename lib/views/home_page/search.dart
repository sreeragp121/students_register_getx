import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controllers/student_data_controller.dart';

class MySearchBar extends StatelessWidget {
   MySearchBar({super.key});
 final StudentDataController studentDataController=Get.put(StudentDataController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        // controller: _searchController,
      
        onChanged: (value) {
          studentDataController.searchStudent(value);
        },
        decoration: InputDecoration(
          filled: true,
            hintText: 'search',
            suffixIcon: IconButton(
                onPressed: () async {}, icon: const Icon(Icons.search)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
