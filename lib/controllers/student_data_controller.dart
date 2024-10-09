import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_getx/models/student_model.dart';

class StudentDataController extends GetxController {
  var studentData = <StudentModel>[].obs;

  late Box<StudentModel> studentBox;

  @override
  void onInit() {
    super.onInit();
    studentBox = Hive.box<StudentModel>('studentBox');
    studentData.addAll(studentBox.values.toList());
  }

// Add Student Data
  void addStudent({
    required String name,
    required String age,
    required String phoneNumber,
    required String image,
  }) {
    final newStudent = StudentModel(
        name: name, age: age, phoneNumber: phoneNumber, image: image);
    studentBox.add(newStudent);
    studentData.add(newStudent);
    studentData.refresh();
  }

//delete Student

  void delete({required int index}) async {
    try {
      await studentBox.deleteAt(index);
      studentData.removeAt(index);
    } catch (e) {
      // print('error deleting:$e');
    }
    studentData.refresh();
  }

  void editStudentData(
      {required int index,
      required String name,
      required String age,
      required String phoneNumber,
      required String imagepath}) {
    final editstudent = StudentModel(
        name: name, age: age, phoneNumber: phoneNumber, image: imagepath);
    studentBox.putAt(index, editstudent);
    studentData[index] = editstudent;
    studentData.refresh();
  }

  void searchStudent(String query) {
    if (query.isEmpty) {
      studentData.assignAll(studentBox.values.toList());  
    } else {
      var filteredList = studentBox.values
        .where((student) {
          return student.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      studentData.assignAll(filteredList);
    }
    studentData.refresh();
  }
}
