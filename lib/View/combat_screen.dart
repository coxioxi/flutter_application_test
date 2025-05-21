import 'package:flutter/material.dart';
import 'package:flutter_application_test/Database/game_state.dart';
import 'package:provider/provider.dart';

class CombatScreen extends StatelessWidget{
  const CombatScreen({super.key});

  @override
  Widget build (BuildContext context) {

    final gameId = Provider.of<GameState>(context).gameId;

    return Center(
      child: Text('$gameId'),
    );
  }
}