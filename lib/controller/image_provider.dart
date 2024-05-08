import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService extends ChangeNotifier {
  File? selectedImage;
  ImagePicker imagePicker = ImagePicker();

  Future<String?> uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      notifyListeners();

      // Upload image to Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(selectedImage!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      
      // Return the download URL of the uploaded image
      return await snapshot.ref.getDownloadURL();
    }
    return null;
  }
}
