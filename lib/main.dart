import 'package:flutter/material.dart';
import 'screens/screen_index.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_login.dart';
import 'screens/screen_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'splashscreen',
      routes: {
        '/index': (context) => IndexScreen(),
        '/login': (context) => LoginScreen(),
        '/register' : (context) => RegisterScreen(),
        '/splash': (context) => SplashScreen(),
      },
      initialRoute: '/splash',
    );
  }

}
