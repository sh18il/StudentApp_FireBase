import 'dart:developer';

import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/service/service_task.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../controller/service_controller.dart';

class EditScreen extends StatelessWidget {
  final String name;
  final String age;
  final String address;
  final String rollno;
  final String id;

  const EditScreen({
    Key? key,
    required this.name,
    required this.age,
    required this.address,
    required this.rollno,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("edit_screen");
    final pro = Provider.of<ServiceController>(context, listen: false);
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
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Gap(100),
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Gap(15),
            TextFormField(
              controller: ageCtrl,
              decoration: InputDecoration(
                labelText: "age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Gap(15),
            TextFormField(
              controller: rollNoCtrl,
              decoration: InputDecoration(
                labelText: "RollNo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Gap(15),
            TextFormField(
              controller: addressCtrl,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Gap(15),
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
                  ));
                  Navigator.pop(context);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
