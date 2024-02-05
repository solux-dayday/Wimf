import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        color: Color(0xFFB2DCF0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _nicknameErrorText = '';
  String _idErrorText = '';
  String _passwordErrorText = '';
  String _confirmPasswordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextField(
          _nicknameController,
          '닉네임',
          '닉네임을 입력하세요.',
          _nicknameErrorText,
        ),
        _buildTextField(
          _idController,
          '아이디',
          '아이디를 입력하세요.',
          _idErrorText,
        ),
        _buildPasswordField(
          _passwordController,
          '비밀번호',
          '비밀번호를 입력하세요.',
          _passwordErrorText,
        ),
        _buildPasswordField(
          _confirmPasswordController,
          '비밀번호 확인',
          '비밀번호를 다시 입력하세요.',
          _confirmPasswordErrorText,
        ),
        SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: () {
            // 회원가입 버튼을 눌렀을 때의 동작을 여기에 추가하세요.
            setState(() {
              _nicknameErrorText =
              _nicknameController.text.isEmpty ? '닉네임을 입력하세요.' : '';
              _idErrorText = _idController.text.isEmpty ? '아이디를 입력하세요.' : '';
              _passwordErrorText =
              _passwordController.text.isEmpty ? '비밀번호를 입력하세요.' : '';
              _confirmPasswordErrorText = _confirmPasswordController.text.isEmpty
                  ? '비밀번호를 다시 입력하세요.'
                  : (_passwordController.text != _confirmPasswordController.text
                  ? '비밀번호가 일치하지 않습니다.'
                  : '');
            });

            if (_isInputValid()) {
              String nickname = _nicknameController.text;
              String id = _idController.text;
              String password = _passwordController.text;
              String confirmPassword = _confirmPasswordController.text;

              // 예시로 콘솔에 출력하는 동작을 수행합니다.
              print('닉네임: $nickname');
              print('아이디: $id');
              print('비밀번호: $password');
              print('비밀번호 확인: $confirmPassword');
            }
          },
          child: Text('회원가입'),
        ),
        SizedBox(height: 12.0),
        Text(
          _getErrorMessage(),
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint, String errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText.isEmpty ? null : errorText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String label, String hint, String errorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText.isEmpty ? null : errorText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  bool _isInputValid() {
    return _nicknameController.text.isNotEmpty &&
        _idController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  String _getErrorMessage() {
    if (!_isInputValid()) {
      return '모든 필드를 입력하세요.';
    }
    return '';
  }
}
