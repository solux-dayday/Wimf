// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wimf/models/auth.dart';
// import 'package:wimf/models/register.dart';
// import 'package:wimf/screens/screen_login.dart';
//
// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text('회원가입'),
//       ),
//       body: Container(
//         color: Color(0xFFB2DCF0),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SignUpForm(),
//         ),
//       ),
//     );
//   }
// }
//
// class SignUpForm extends StatefulWidget {
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
//
// class _SignUpFormState extends State<SignUpForm> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//
//   String _emailErrorText = '';
//   String _passwordErrorText = '';
//   String _confirmPasswordErrorText = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         EmailInput(_emailController, _emailErrorText),
//         Container(
//           child: _buildPasswordField(
//             _passwordController,
//             '비밀번호',
//             '비밀번호를 입력하세요.',
//             _passwordErrorText,
//           ),
//         ),
//         Container(
//           child: _buildPasswordField(
//             _confirmPasswordController,
//             '비밀번호 확인',
//             '비밀번호를 다시 입력하세요.',
//             _confirmPasswordErrorText,
//           ),
//         ),
//         SizedBox(height: 24.0),
//         ElevatedButton(
//           onPressed: () {
//             // 회원가입 버튼을 눌렀을 때의 동작을 여기에 추가하세요.
//             // error message
//             setState(() {
//               _emailErrorText = _emailController.text.isEmpty ? '아이디를 입력하세요.' : '';
//               _passwordErrorText =
//               _passwordController.text.isEmpty ? '비밀번호를 입력하세요.' : '';
//               _confirmPasswordErrorText = _confirmPasswordController.text.isEmpty
//                   ? '비밀번호를 다시 입력하세요.'
//                   : (_passwordController.text != _confirmPasswordController.text
//                   ? '비밀번호가 일치하지 않습니다.'
//                   : '');
//             });
//             // 입력한 email, password, confirm password
//             if (_isInputValid()) {
//               final register = Provider.of<RegisterModel>(context, listen: false);
//               String email = _emailController.text;
//               String password = _passwordController.text;
//               String confirmPassword = _confirmPasswordController.text;
//
//               // 예시로 콘솔에 출력하는 동작을 수행합니다.
//               print('이메일: $email');
//               print('비밀번호: $password');
//               print('비밀번호 확인: $confirmPassword');
//             }
//           },
//           child: Text('회원가입'),
//         ),
//         SizedBox(height: 12.0),
//         Text(
//           _getErrorMessage(),
//           style: TextStyle(color: Colors.red),
//         ),
//       ],
//     );
//   }
// // Widget EmailInput(
// //     TextEditingController _emailController, String _emailErrorText) {
// //   this._emailController = _emailController;
// //   this._emailErrorText = _emailErrorText;
// //   @override
// //   Widget build(BuildContext context) {
// //     final register = Provider.of<RegisterModel>(context, listen: false);
// //     return Container(
// //       padding: EdgeInsets.all(5),
// //       child: _buildTextField(
// //         _emailController,
// //         '이메일',
// //         '이메일을 입력하세요.',
// //         _emailErrorText,
// //       ),
// //     );
// //   }
// // }
//
//   // 화면
//   Widget _buildTextField(
//       TextEditingController controller, String label, String hint, String errorText) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           errorText: errorText.isEmpty ? null : errorText,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPasswordField(
//       TextEditingController controller, String label, String hint, String errorText) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         obscureText: true,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           errorText: errorText.isEmpty ? null : errorText,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   bool _isInputValid() {
//     return _emailController.text.isNotEmpty &&
//         _passwordController.text.isNotEmpty &&
//         _confirmPasswordController.text.isNotEmpty &&
//         _passwordController.text == _confirmPasswordController.text;
//   }
//
//   String _getErrorMessage() {
//     if (!_isInputValid()) {
//       return '모든 필드를 입력하세요.';
//     }
//     return '';
//   }
// }
//
// class EmailInput extends StatelessWidget {
//   this._emailController = _emailController;
//   this._emailErrorText = _emailErrorText;
//   @override
//   Widget build(BuildContext context) {
//     final register = Provider.of<RegisterModel>(context, listen: false);
//     return Container(
//       padding: EdgeInsets.all(5),
//       child: _buildTextField(
//         _emailController,
//         '이메일',
//         '이메일을 입력하세요.',
//         _emailErrorText,
//       ),
//     );
//   }
// };