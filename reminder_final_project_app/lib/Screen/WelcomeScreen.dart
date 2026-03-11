import 'package:flutter/material.dart';
import '../Design/Color.dart';
import '../State/LoginOrSignup.dart';



class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -60,
            left: -50,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.pink[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -50,
            right: -145,
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 65,
            right: -175,
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -250,
            right: 40,
            child: Container(
              height: 500,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -175,
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      Text(
                        "REMINDER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: txtMainColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Loginstate()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: txtMainColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: lightBlue,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
