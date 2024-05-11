
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/service/service_task.dart';
import 'package:flutter/material.dart';

class ServiceController extends ChangeNotifier {
  // final TextEditingController nameCtrl = TextEditingController();
  // final TextEditingController ageCtrl = TextEditingController();
  // final TextEditingController addressCtrl = TextEditingController();
  // final TextEditingController rollNoCtrl = TextEditingController();
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ServiceCrud _service = ServiceCrud();
  Future<ModelApp?> addData(ModelApp task) async {
    final addData = await _service.createTask(task);
   
    return addData;
  }

  Stream<List<ModelApp>> getData() {
    return _service.getAllTask();
  }

  Future<void> updateData(ModelApp task) async {
    await _service.updateTask(task);
  }

  Future<void> deleteData(String id) async {
    await _service.deleteTask(id);
    notifyListeners();
  }

  // void addTask(BuildContext context) async {
  //   final pro = Provider.of<ImageService>(context, listen: false);
  //   // await pro.imageAdder(File(pro.file!.path));
  //   if (formKey.currentState!.validate()) {
  //     String id = Uuid().v1();
  //     ModelApp appModel = ModelApp(
  //       id: id,
  //       name: nameCtrl.text,
  //       age: ageCtrl.text,
  //       address: addressCtrl.text,
  //       rollno: rollNoCtrl.text,
  //       image: pro.downloadurl,
  //     );

  //     try {
  //       await addData(appModel);

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Task created")),
  //       );

  //       nameCtrl.clear();
  //       ageCtrl.clear();
  //       addressCtrl.clear();
  //       rollNoCtrl.clear();
  //       Navigator.pop(context);
  //     } catch (e) {
  //       // Handle any errors that occur during task creation
  //       print("Error creating task: $e");
  //     }
  //   }
  }

// class ServiceController extends ChangeNotifier {
//   final ServiceCrud _serviceCrud = ServiceCrud();

//   Stream<List<ModelApp>> getAllTasks() {
//     return _serviceCrud.getAllTask();
//   }

//   Future<void> updateTask(ModelApp task) async {
//     await _serviceCrud.updateTask(task);
//     notifyListeners();
//   }

//   Future<void> deleteTask(String id) async {
//     await _serviceCrud.deleteTask(id);
//     notifyListeners();
//   }

//   Future<ModelApp?> createTask(ModelApp task) async {
//     final createdTask = await _serviceCrud.createTask(task);
//     notifyListeners();
//     return createdTask;
//   }
// }
