import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screen/HomeScreen.dart';
import 'LoginOrSignup.dart';



class loginOrHome extends StatefulWidget {
  const loginOrHome({super.key});

  @override
  State<loginOrHome> createState() => _loginOrHomeState();
}

class _loginOrHomeState extends State<loginOrHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData)//login
                { return Homescreen(); }
            else
            { return Loginstate();}

          }),
    );
  }
}