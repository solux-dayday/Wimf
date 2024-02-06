import 'package:firebase_core/firebase_core.dart';
import 'package:wimf/models/recipe_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:wimf/firebase_options.dart';
import 'package:wimf/models/auth.dart';
import 'package:flutter/material.dart';
import 'screens/screen_index.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_login.dart';
import 'screens/screen_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: MaterialApp(
        title: 'Wimf',
        debugShowCheckedModeBanner: false,
        routes: {
          '/index': (context) => IndexScreen(),
          '/login': (context) => LoginScreen(),
          '/splash': (context) => SplashScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}
