import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  String? _gameId;

  String? get gameId => _gameId;

  void setGameId(String id) {
    _gameId = id;
    notifyListeners();
  }
}