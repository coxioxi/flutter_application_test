import 'package:flutter/material.dart';
//import 'package:flutter_application_test/game_list_screen.dart';
//import 'sign_up_screen.dart';
//import 'game_list_screen.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen>{

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed:() {
                //TODO: uncoment when ready for user auth 
                //Navigator.pushReplacement(
                //  context, 
                //  MaterialPageRoute(builder: (context) => const GameListScreen()),
                //);
              },
              child: const Text('Log In'),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: (){
                //TODO: uncoment when ready for user auth 
                //Navigator.pushReplacement(
                //  context,
                //  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                //);
              }, 
              child: const Text('Sign Up'))
          ],
        ),
      )
    );
  } 
}