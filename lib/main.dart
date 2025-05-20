import 'package:flutter/material.dart';
import 'package:flutter_application_test/View/game_list_screen.dart';
import 'package:flutter_application_test/Database/game_state.dart';
import 'package:provider/provider.dart';
import 'Database/objectBox.dart';

late Objectbox objectbox;

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await Objectbox.create();

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



