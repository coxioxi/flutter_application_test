import 'package:flutter/material.dart';
import 'package:flutter_application_test/main_screen.dart';

void main(){
  runApp(TestApp());
}

class TestApp extends StatelessWidget{
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MainScreen(),
    );
  }
}



