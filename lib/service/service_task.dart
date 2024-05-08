import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceCrud {
  final CollectionReference _crudcollection =
      FirebaseFirestore.instance.collection("task");

  //create
  Future<ModelApp?> createTask(ModelApp task) async {
    try {
      final taskMap = task.toJson();
      await _crudcollection.doc(task.id).set(taskMap);
      return task;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  //get all

  Stream<List<ModelApp>> getAllTask() {
    try {
      return _crudcollection.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return ModelApp.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } on FirebaseException catch (e) {
      print(e);
      throw e;
    }
  }

  //update

  Future<void> updateTask( ModelApp task) async {
    try {
      await _crudcollection.doc(task.id).update(task.toJson());
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  //delete

  Future<void> deleteTask(String id) async {
    try {
      await _crudcollection.doc(id).delete();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
