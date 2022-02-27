import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseloginsignup/auth_controller.dart';
import 'package:firebaseloginsignup/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



// for firebase 
//instagram @ codewithkashmir

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value)=> Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

