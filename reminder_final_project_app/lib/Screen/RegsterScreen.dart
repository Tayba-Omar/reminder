import 'package:flutter/material.dart';
import '../Component/CustomTextFormFeild.dart';
import '../Design/Color.dart';
import '../Services/Auth/AuthServices.dart';
import 'HomeScreen.dart';

class RegsterScreen extends StatefulWidget {
  void Function() isLogin;
  RegsterScreen({required this.isLogin});

  @override
  State<RegsterScreen> createState() => _RegsterScreenState();
}

class _RegsterScreenState extends State<RegsterScreen> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController RepetedPasswordController = TextEditingController();

  Regster() async {
    if (PasswordController.text == RepetedPasswordController.text) {
      AuthService auth = AuthService();
      String r = await auth.register(EmailController.text, PasswordController.text);

      if (r == "done") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      } else {
        return showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            title: Text(
              r,
              style: TextStyle(color: txtMainColor),
            ),
          ),
        );
      }
    } else {
      return showDialog(
        context: context,
        builder: (builder) => AlertDialog(
          title: Text(
            "Passwords do not match",
            style: TextStyle(color: txtMainColor),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Circles
          Positioned(
            top: -60,
            left: -50,
            child: Container(
              height: 300,
              width: 300,
              decoration:  BoxDecoration(
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

          // Main UI
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: screenWidth * 0.11,
                        color: txtMainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textformfiled(
                        lbl: "Username",
                        controller: EmailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textformfiled(
                        lbl: "Password",
                        controller: PasswordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textformfiled(
                        lbl: "Rewrite Password",
                        controller: RepetedPasswordController,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: Regster,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: txtMainColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: lightBlue,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: widget.isLogin,
                      child: Text(
                        "Already a User? Log in",
                        style: TextStyle(
                          color: txtMainColor,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
