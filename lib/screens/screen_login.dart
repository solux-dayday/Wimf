import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wimf/models/auth.dart';
import 'package:wimf/models/login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginModel(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFB2DCF0),
          ),
          backgroundColor: Color(0xFFB2DCF0),
          body: SingleChildScrollView(
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EmailInput(),
              PasswordInput(),
              LoginButton(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Divider(
                  thickness: 5,
                  color: Colors.white,
                ),
              ),
              RegisterButton(),
            ],
          ),
        ),
        ),
    );
  }
}


class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 'path_to_your_logo_image'를 실제 로고 이미지의 경로 또는 애셋 이름으로 대체하세요
    return Image.asset(
      'assets/images/logochef.png',
      width: MediaQuery.of(context).size.width * 0.5, // 필요에 따라 너비 조절
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        onChanged: (email) {
          login.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        onChanged: (password) {
          login.setPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          helperText: '',
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authClient =
    Provider.of<FirebaseAuthProvider>(context, listen: false);
    final login = Provider.of<LoginModel>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.blue,
        ),
        onPressed: () async {
          await authClient
              .loginWithEmail(login.email, login.password)
              .then((loginStatus) {
            if (loginStatus == AuthStatus.loginSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content:
                    Text('welcome! ' + authClient.user!.email! + ' ')));
              Navigator.pushReplacementNamed(context, '/index');
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('login fail')));
            }
          });
        },
        child: Text('Login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),),
      ),
    );
  }
}


class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register');
        },
        child: Text(
          'Regist by email',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 20,
          ),
        ));
  }
}