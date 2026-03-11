import 'package:flutter/cupertino.dart';
import '../Screen/LoginScreen.dart';
import '../Screen/RegsterScreen.dart';



class Loginstate extends StatefulWidget {
  const Loginstate({super.key});

  @override
  State<Loginstate> createState() => _LoginstateState();
}

class _LoginstateState extends State<Loginstate> {
  bool isLogin = false;
  change(){
    setState(() {
      isLogin=!isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isLogin==false){
      return LogInScreen(isLogin: change,);}
    else{
      return RegsterScreen(isLogin: change,);
    }
  }
}