import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/service/service_task.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageService extends ChangeNotifier {
  File? file;
  final ImagePicker imagePicker = ImagePicker();
  ServiceCrud studentService = ServiceCrud();
  String imagename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = "";

  Stream<QuerySnapshot<ModelApp>> getStudents() {
    return studentService.studentRef.snapshots();
  }

  Future<void> uploadImage() async {
    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      final File imageFile = File(pickedImage.path);
      final String imageName = DateTime.now().microsecondsSinceEpoch.toString();

      final Reference ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('$imageName.jpg');
      final UploadTask uploadTask = ref.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        downloadurl = await ref.getDownloadURL();
        if (kDebugMode) {
          print('Image uploaded successfully. Download URL: $downloadurl');
        }
        notifyListeners();
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error uploading image: $error');
      }
      throw Exception('Error uploading image: $error');
    }
  }

  imageUpdate(imageurl, updatedimage) async {
    try {
      Reference editpic = FirebaseStorage.instance.refFromURL(imageurl);
      await editpic.putFile(updatedimage);
      downloadurl = await editpic.getDownloadURL();
    } catch (error) {
      return Exception('image is not updated$error');
    }
  }

  deleteImage(imageurl) async {
    try {
      Reference delete = FirebaseStorage.instance.refFromURL(imageurl);
      await delete.delete();
      if (kDebugMode) {
        print('image deleted successfully');
      }
    } catch (error) {
      return Exception('image is not deleted $error');
    }
  }

  ///..................................................
  ImagePicker image = ImagePicker();
  Future<void> getCam(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }
}
