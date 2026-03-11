import 'package:flutter/material.dart';
import '../Component/CustomTextFormFeild.dart';
import '../Design/Color.dart';
import '../Services/Auth/AuthServices.dart';
import 'HomeScreen.dart';

class LogInScreen extends StatefulWidget {
  void Function () isLogin ;
  LogInScreen({required this.isLogin});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController EmailController =TextEditingController();
  TextEditingController PasswordController=TextEditingController() ;

  logIn ()async {

      AuthService auth = AuthService();
      String r = await auth.signIn(EmailController.text, PasswordController.text);
      if (r == "done") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      } else {
        return showDialog(
          context: context,
          builder: (builder) => AlertDialog(
            title: Text(r,
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
            bottom:-40,
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
                        "LOG IN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: txtMainColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Textformfiled(
                          lbl: "Username",
                          controller: EmailController,
                          textColor: txtMainColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Textformfiled(
                          lbl: "Password",
                          controller: PasswordController,
                          textColor: txtMainColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: logIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: txtMainColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: lightBlue,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: widget.isLogin,
                        child: Text(
                          "New Account ??",
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
          )
        ],
      ),
    );
  }
}
