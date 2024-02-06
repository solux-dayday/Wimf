import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin){
      if(isLogin){
        Navigator.of(context).pushReplacementNamed('/index');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }


  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), (){ //splash 화면 보여지는 시간(지금 2.5초)
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : null,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logochef.png', // Make sure to replace 'logo.png' with your actual image file name
              width: 100, // Adjust the width as needed
              height: 100, // Adjust the height as needed
            ),
            SizedBox(height: 16),
            Text("Wimf",
            style: TextStyle(
              fontWeight: FontWeight.bold, //폰트 굵기 : 진하게
              color: Colors.white,
              fontSize: 24,),),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}