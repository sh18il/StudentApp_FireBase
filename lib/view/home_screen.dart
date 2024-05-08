import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/controller/service_controller.dart';
import 'package:firebase_crud/view/edit_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:firebase_crud/service/service_task.dart';
import 'package:firebase_crud/view/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("homePage");

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pro = Provider.of<ServiceController>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(221, 72, 124, 179),
        shape: CircleBorder(
          side: BorderSide(
              color: const Color.fromARGB(255, 255, 255, 255),
              strokeAlign: BorderSide.strokeAlignOutside),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddScreen(),
          ));
        },
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/qqqq.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: StreamBuilder<List<ModelApp>>(
          stream: pro.getData(),
          // FirebaseFirestore.instance.collection("task").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ModelApp>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  child: ListView.separated(
                    itemBuilder: (_, i) {
                      final delay = (i * 300);
                      return Container(
                        decoration: BoxDecoration(
                            color: Color(0xff242424),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            FadeShimmer.round(
                              size: 60,
                              fadeTheme: FadeTheme.dark,
                              millisecondsDelay: delay,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeShimmer(
                                    height: 8,
                                    width: 150,
                                    radius: 4,
                                    millisecondsDelay: delay,
                                    fadeTheme: FadeTheme.light),
                                SizedBox(
                                  height: 6,
                                ),
                                FadeShimmer(
                                    height: 8,
                                    millisecondsDelay: delay,
                                    width: 170,
                                    radius: 4,
                                    fadeTheme: FadeTheme.dark),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: 20,
                    separatorBuilder: (_, __) => SizedBox(
                      height: 16,
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error occurred"),
              );
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ModelApp d = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slidable(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/night.jpg'),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 120, 119, 119)),
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            d.name ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(d.age.toString(),
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      endActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            pro.deleteData(d.id!);
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditScreen(
                                name: d.name.toString(),
                                age: d.age.toString(),
                                address: d.address.toString(),
                                rollno: d.rollno.toString(),
                                id: d.id.toString(),
                              ),
                            ));
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Share',
                        ),
                      ]),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Text(
                "No data available",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
