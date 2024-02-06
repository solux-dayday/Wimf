import 'package:flutter/material.dart';

class ScreenMainRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('screen_main_register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('screen_main_register 페이지 내용'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // 등록 완료 버튼을 누를 때, 결과를 돌려줌
                Navigator.pop(context, true); // 여기서 결과값을 true로 돌려줍니다.
              },
              child: Text('등록 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
