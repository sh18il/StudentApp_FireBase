import 'dart:developer';

import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/controller/service_controller.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/view/bottom_nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatelessWidget {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController rollNoCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/360_F_564999540_XdTvqLGDpneB3v4ifz0SZgzxMOFmfoVo.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  const Gap(50),
                  // FutureBuilder(
                  //   future:
                  //       Future.value(Provider.of<ImageService>(context).file),
                  //   builder: (context, snapshot) {
                  //     return CircleAvatar(
                  //       radius: 40,
                  //       backgroundImage: snapshot.data != null
                  //           ? FileImage(snapshot.data!)
                  //           : null,
                  //     );
                  //   },
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            provider.uploadImage();
                          },
                          child: const Text("take pic"))
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       final provider = Provider.of<ImageService>(context,
                      //           listen: false);
                      //       final imageUrl = await provider.uploadImage();
                      //       if (imageUrl != null) {
                      //         final pro = Provider.of<ServiceController>(
                      //             context,
                      //             listen: false);
                      //         pro.createTask(context, imageUrl);
                      //       } else {
                      //          Handle error
                      //       }
                      //     },
                      //     child: Text('camera')),
                      // ElevatedButton(
                      //     onPressed: () {

                      //     },
                      //     child: Text('gellary')),
                    ],
                  ),
                  const Gap(50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: nameCtrl,
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
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: ageCtrl,
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
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: addressCtrl,
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
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 127, 124, 124),
                    ),
                    child: TextFormField(
                      controller: rollNoCtrl,
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
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      addTask(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>  BottomNavBar(),
                      ));
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask(BuildContext context) async {
    final pro = Provider.of<ImageService>(context, listen: false);
    final provid = Provider.of<ServiceController>(context, listen: false);
    // await pro.imageAdder(File(pro.file!.path));
    if (formKey.currentState!.validate()) {
      String id = const Uuid().v1();
      ModelApp appModel = ModelApp(
        id: id,
        name: nameCtrl.text,
        age: ageCtrl.text,
        address: addressCtrl.text,
        rollno: rollNoCtrl.text,
        image: pro.downloadurl,
      );

      try {
        await provid.addData(appModel);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Task created")),
        );

        nameCtrl.clear();
        ageCtrl.clear();
        addressCtrl.clear();
        rollNoCtrl.clear();
      } catch (e) {
        
        if (kDebugMode) {
          print("Error creating task: $e");
        }
      }
    }
  }
}
