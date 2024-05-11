import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/controller/image_provider.dart';
import 'package:firebase_crud/controller/service_controller.dart';
import 'package:firebase_crud/service/firebase_options.dart';
import 'package:firebase_crud/view/home_screen.dart';
import 'package:firebase_crud/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ServiceController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImageService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
