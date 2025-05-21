import 'package:flutter/material.dart';
import 'package:flutter_application_test/main.dart';
import 'package:flutter_application_test/Database/data_model.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';
import 'package:flutter_application_test/Database/game_state.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreen();
}

class _GameListScreen extends State<GameListScreen>{
  TextEditingController gameName = TextEditingController();

  DM? dm;

  @override
  void initState() {
    super.initState();
    _initDm();
  }

  void _initDm() {
    final existingDm = objectbox.getDm('firebaseUid');

    if(existingDm != null) {
      setState(() {
        dm = existingDm;
      });
    }
    else {
      // Create and save a new DMS
      final newDm = DM(name: 'name', firebaseUid: 'firebaseUid');
      objectbox.addDm(newDm.name, newDm.firebaseUid); 
      setState(() {
        dm = newDm;
      });
    }
  }
  
  @override
  Widget build (BuildContext context) {

    if (dm == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Games'),
      ),
      
      body: StreamBuilder(
        stream: objectbox.getGames(dm!), 
        builder: (context, snapshot) {
          
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final games = snapshot.data!;

          if(games.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open_outlined,
                    size: 40, 
                  ),
                  Text(
                    'No Games Found',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ]
              ),
            );
          } 

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              
              return Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  final gameId = game.id;
                  debugPrint('$gameId');
                  Provider.of<GameState>(context, listen: false).setGameId(game.id);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainScreen()),);
                }, 
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: ListTile(
                    title: Text(game.name),
                    subtitle: Text(game.createdAt.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Are you sure you wanna delete this game?'),

                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(), 
                                child: const Text('Back')
                              ),
                              
                              TextButton(
                                onPressed: () {
                                  objectbox.removeGame(game);
                                  Navigator.of(context).pop();
                                }, 
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red)
                                )
                                
                              ),
                            ],
                          )
                        );
                      }, 
                      icon: Icon(Icons.delete)),
                  ),
                  ),
                ),
              );
            }
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showDialog(
            context: context, 
            builder: (BuildContext context) => AlertDialog(
              title: Text('Create a Game'),

              content: TextField(
                controller: gameName,
                autofocus: true,

                decoration: const InputDecoration(
                  hintText: 'Enter Game Name'
                ),
              ),
              
              actions: [
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    objectbox.addGame(gameName.text, DateTime.now(), dm!);
                    gameName.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }),
        tooltip: 'Create a New Game',
        child: const Icon(Icons.add)
      ),
    );
  }
}