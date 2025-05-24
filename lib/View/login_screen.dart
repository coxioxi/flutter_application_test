import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'game_list_screen.dart';


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
      appBar: AppBar(title: const Text('Login'),),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          // User name text field
          TextField(
            controller: _username,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          // Password text field
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 16),

          // Login button, push and replaces with game screen view
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GameListScreen()),
              );
            }, 
            child: const Text('Login')
          ),

          SizedBox(height: 16),

          // Sign up gesture detector, takes to the sign up page
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen())
            ),
            
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: "Don't have an account? ",
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => SignUpScreen())
                        );
                      }
                    )
                  ]
                ),
              )
            )
          )
        ],
      ),
    );
  } 
}