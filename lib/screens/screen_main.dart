import 'package:flutter/material.dart';
import 'package:wimf/screens/screen_main_ingredient.dart';


class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isRegistered = false; // 등록 여부를 저장하는 변수
  bool showAddButton = false; // 추가 버튼 표시 여부를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyContent(
        isRegistered: isRegistered,
        onRegister: () {
          // screen_main_register 페이지로 이동하고 결과 받기
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenMainRegister(),
            ),
          ).then((result) {
            // 결과에 따라 상태 업데이트
            setState(() {
              isRegistered = result ?? false;
              showAddButton = isRegistered;
            });
          });
        },
        showAddButton: showAddButton,
      ),
    );
  }
}

class BodyContent extends StatelessWidget {
  final bool isRegistered;
  final Function() onRegister;
  final bool showAddButton;

  BodyContent({
    required this.isRegistered,
    required this.onRegister,
    required this.showAddButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0583f2), Color(0xFF05dbf2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),  // 왼쪽 위 모서리
          topRight: Radius.circular(20.0), // 오른쪽 위 모서리
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // 패딩 설정
      child: Column(
        children: [
          SizedBox(height: 25.0), // 컨테이너와 컨테이너 사이의 간격
          Row(
            children: [
              Text(
                '나의 냉장고',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(width: 145.0),
              Expanded(
                child: ButtonWidget(
                  onPressed: onRegister,
                  label: isRegistered ? '아이콘 변경' : '등록하기',
                ),
              )
            ],
          ),
          SizedBox(height: 15.0), // 추가 간격
          RoundedBox(), // 새로운 둥근 박스 위젯
          SizedBox(height: 20.0), // 추가 간격
          if (showAddButton) AddButton(), // 추가 버튼 표시
        ],
      ),
    );
  }
}

class RoundedBox extends StatelessWidget {
  final List<Map<String, dynamic>> ingredients = [
    {"image": "assets/images/icon/eggCircle.png", "name": "계란", "expiration": "2024-04-05", "count": 3},
    {"image": "assets/images/icon/fishCircle.png", "name": "생선", "expiration": "2024-02-08", "count": 3},
    {"image": "assets/images/icon/meatCircle.png", "name": "돼지고기", "expiration": "2024-02-08", "count": 3},
    {"image": "assets/images/icon/vegeCircle.png", "name": "당근", "expiration": "2024-02-14", "count": 3},
    {"image": "assets/images/icon/milkCircle.png", "name": "우유", "expiration": "2024-02-17", "count": 3},
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 590,
          width: double.infinity,
        ),
        Positioned(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  var ingredient = ingredients[index];
                  return Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // 이미지 버튼을 누르면 screen_main_ingredient 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenMainIngredient(ingredient),
                              ),
                            );
                          },
                          child: Image.asset(
                            ingredient['image']!,
                            width: 50.0,
                            height: 50.0,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Colors.blue,
                            onPrimary: Colors.black,
                          ),
                        ),
                        Text(
                          ingredient['name']!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ScreenMainIngredient extends StatelessWidget {
  final Map<String, dynamic> ingredient;
  ScreenMainIngredient(this.ingredient);

  @override
  Widget build(BuildContext context) {
    String expiration = ingredient['expiration'];
    String expirationStatus = compareExpiration(expiration);
    int remainingDays = calculateRemainingDays(expiration);

    return Scaffold(
      appBar: AppBar(
        title: Text('식재료 정보'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Text('Ingredient: ${ingredient['name']}'),
            Text('유통기한: $expiration'),
            Text('개수: ${ingredient['count']}'),
            // Display the expiration status
            Text('유통기한 확인: $expirationStatus'),
            // Display the remaining days
            Text('남은 일수: ${remainingDays < 0 ? '유통기한이 지났습니다.' : '$remainingDays 일'}'),
          ],
        ),
      ),
    );
  }
}


class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  ButtonWidget({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: Colors.white,
      ),
      child: Text(label),
    );
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // 추가 버튼 동작
        // 여기에 추가 동작을 구현하세요.
      },
      child: Text('추가 버튼'),
    );
  }
}

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
                Navigator.pop(context, true);
              },
              child: Text('등록 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
