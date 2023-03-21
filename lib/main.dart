import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/objectbox_initializer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backend/binding.dart';
import 'ui/auth/login.dart';

late ViewModel vm;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  vm = await ViewModel.create();

  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Planner App',
      initialBinding: MainBinding(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const Login(),
    );
  }
}
