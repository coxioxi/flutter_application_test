import 'package:flutter/material.dart';
import 'package:flutter_application_test/game_list_screen.dart';
import 'package:flutter_application_test/game_state.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: TestApp(),
      )
    );
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
      home: GameListScreen(),
    );
  }
}



