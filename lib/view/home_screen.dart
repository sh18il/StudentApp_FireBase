import 'dart:developer';

import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/controller/service_controller.dart';
import 'package:firebase_crud/view/edit_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_crud/model/crud_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("homePage");

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
        child: Consumer<ServiceController>(builder: (context, pro, _) {
          return StreamBuilder<List<ModelApp>>(
            stream: pro.getData(),
            // FirebaseFirestore.instance.collection("task").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<List<ModelApp>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ListView.separated(
                    itemBuilder: (_, i) {
                      final delay = (i * 300);
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff242424),
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            FadeShimmer.round(
                              size: 60,
                              fadeTheme: FadeTheme.dark,
                              millisecondsDelay: delay,
                            ),
                            const SizedBox(
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
                                const SizedBox(
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
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 16,
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error occurred"),
                );
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    ModelApp d = snapshot.data![index];
                    final imageUrl = d.image ?? "assets/images/image.jpeg";

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              if (d.id != null) {
                                pro.deleteData(d.id!);
                                Provider.of<ImageService>(context,
                                        listen: false)
                                    .deleteImage(d.image);
                              } else {
                                // Handle null or missing data
                                if (kDebugMode) {
                                  print('ModelApp object or id is null');
                                }
                              }
                            },
                            backgroundColor: Colors.transparent,
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
                                  image: d.image,
                                ),
                              ));
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ]),
                        child: Container(
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/abstract-digital-art-mi.jpg'),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 120, 119, 119)),
                          child: ListTile(
                            leading: ClipRect(
                              child: CircleAvatar(
                                child: Image(
                                    image: NetworkImage(imageUrl.toString())),
                              ),
                            ),
                            title: Text(
                              d.name ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(d.age.toString(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text(
                  "No data available",
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
