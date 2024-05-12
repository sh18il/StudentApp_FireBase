import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/controller/service_controller.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  String? name;
  String? age;
  String? address;
  String? rollno;
  String? id;
  String? image;

  EditScreen({
    Key? key,
    this.name,
    this.age,
    this.address,
    this.rollno,
    this.id,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("edit_screen");
    final pro = Provider.of<ServiceController>(context, listen: false);
    final imageProvider = Provider.of<ImageService>(context, listen: false);
    final TextEditingController nameCtrl = TextEditingController(text: name);
    final TextEditingController ageCtrl = TextEditingController(text: age);
    final TextEditingController addressCtrl =
        TextEditingController(text: address);
    final TextEditingController rollNoCtrl =
        TextEditingController(text: rollno);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/360_F_564999540_XdTvqLGDpneB3v4ifz0SZgzxMOFmfoVo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(100),
              SizedBox(
                height: height * 0.2,
                child: Image(image: NetworkImage(image.toString())),
              ),
              TextButton(
                onPressed: () async {
                  final updatedImage = imageProvider.uploadImage();

                  await imageProvider.imageUpdate(image!, updatedImage);
                },
                child: const Text("Edit Image"),
              ),
              const Gap(30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 143, 143, 143),
                ),
                child: TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 143, 143, 143),
                ),
                child: TextFormField(
                  controller: ageCtrl,
                  decoration: InputDecoration(
                    labelText: "age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 127, 124, 124),
                ),
                child: TextFormField(
                  controller: rollNoCtrl,
                  decoration: InputDecoration(
                    labelText: "RollNo",
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 143, 143, 143),
                ),
                child: TextFormField(
                  controller: addressCtrl,
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    pro.updateData(ModelApp(
                        id: id,
                        name: nameCtrl.text,
                        age: ageCtrl.text,
                        address: addressCtrl.text,
                        rollno: rollNoCtrl.text,
                        image: image));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
