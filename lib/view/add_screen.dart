import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/controller/service_controller.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/service/service_task.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("add_screen");
    final pro = Provider.of<ServiceController>(context, listen: false);
    final provider = Provider.of<ImageService>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/qqqq.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Form(
              key: pro.formKey,
              child: Column(
                children: [
                  Gap(50),
                  if (provider.selectedImage != null)
                    CircleAvatar(
                      child: Image.file(provider.selectedImage!),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final provider = Provider.of<ImageService>(context,
                                listen: false);
                            final imageUrl = await provider.uploadImage();
                            if (imageUrl != null) {
                              final pro = Provider.of<ServiceController>(
                                  context,
                                  listen: false);
                              pro.createTask(context, imageUrl);
                            } else {
                              // Handle error
                            }
                          },
                          child: Text('camera')),
                      ElevatedButton(
                          onPressed: () {
                          
                          },
                          child: Text('gellary')),
                    ],
                  ),
                  Gap(100),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: pro.nameCtrl,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: pro.ageCtrl,
                      decoration: InputDecoration(
                        labelText: "Age",
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
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: pro.addressCtrl,
                      decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: pro.rollNoCtrl,
                      decoration: InputDecoration(
                        labelText: "Roll No",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your roll number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      pro.addTask(context);
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
