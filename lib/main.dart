import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui/auth/login.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Planner App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const Login(),
    );
  }
}
