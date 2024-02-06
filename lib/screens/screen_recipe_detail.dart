//레시피 상세 페이지
import 'package:flutter/material.dart';
import 'package:wimf/models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget{
  //선택된 커피 메뉴를 item이란 변수에 전달.
  const RecipeDetailScreen({super.key, required this.item});
  final Recipe item; //전달된 item을 Recipe 형식으로 선언

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>{
  @override
  Widget build(BuildContext context){
    Recipe thisRecipe = widget.item; //전달받은 값을 thisRecipe 변수에 담아 사용

    // MediaQuery를 통해 화면 크기를 얻어오기
    final appSize = MediaQuery.of(context).size;

    //재사용 매소드 : titleSection - 레시피 제목 + 설명
    Padding titleSection = Padding(padding: const EdgeInsets.all(16.0),
      child: Column( //위젯 세로방향 배치
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //제목
          Text("${thisRecipe.title}",
            style: TextStyle(
              fontWeight: FontWeight.bold, //폰트 굵기 : 진하게
              fontSize: 24, //폰트 크기 : 24
            ),
          ),
          //소개
          Text("${thisRecipe.explain}",
            style: TextStyle(
              color: Colors.grey[800], //폰트 색상 : 회색
              fontSize: 16, //폰트 크기 : 16
            ),),
        ],
      ),);

    //재사용 메소드 : buildIconLabelRow
    Row buildIconLabelRow(IconData icon, String label, Color color) {
      return Row( //Row1 인원
        mainAxisAlignment: MainAxisAlignment.start,
        children : [
          Icon(icon, color: color), //아이콘 : 몇인분
          Container(
            margin: const EdgeInsets.only(left: 8.0), //왼쪽에 4px 여백
            child: Text(
              label,
              style : TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    } //buildIconLabelRow

    //재사용 매소드 : iconSection
    Row iconSection = Row( //아이콘, 텍스트 위젯을 가로로 배치
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, //수평 왼쪽 정렬
      children: [ //Row1 인원, Row2 시간, Row3난이도
        buildIconLabelRow(Icons.people, '${thisRecipe.peoplenum}',Colors.grey), //인분
        buildIconLabelRow(Icons.alarm, '${thisRecipe.maketime}',Colors.grey), //조리시간
        buildIconLabelRow(Icons.star, '${thisRecipe.level}',Colors.grey), //난이도
        ],
    );

    Widget stepSection = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column( //위젯 세로 배치
        crossAxisAlignment: CrossAxisAlignment.start, //가로 방향 시작부분에 정렬
        children: [
          //조리 순서 제목
          Text('조리 순서',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //세로 방향의 위쪽에 정렬
            children: [
              Padding(padding: const EdgeInsets.only(right: 8.0),
              child : Column(
                children: [
                  for(int i=0; i < thisRecipe.steps.length; i++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: const EdgeInsets.only(right: 8.0),
                        child: Text("${i+1}",
                          style: Theme.of(context).textTheme.titleLarge,),
                        ),
                        SizedBox(
                          width: appSize.width * 0.8,
                          child: Text("${thisRecipe.steps[i]}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    )
                ],
              ),
              ),

            ], //children
          ),
          ),
        ],
      ),
    );

    Widget ingredientSection(Recipe thisRecipe) {
      return Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '재료 정보',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16.0),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 4,
              ),
              itemCount: thisRecipe.ingredient.length,
              itemBuilder: (context, index) {
                // null-aware 연산자를 사용하여 null 체크
                String foodAmount = thisRecipe.food_amount[index].toString() ?? '';
                String foodUnit = thisRecipe.food_unit[index].toString() ?? '';

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        thisRecipe.ingredient[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0), // 아이템 간 간격 조절
                    Text(
                      '${foodAmount.toString()} ${foodUnit.toString()}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    //화면 그리기
    return Scaffold(
      appBar: AppBar(title: Text("${thisRecipe.title}"),),
      body: ListView(
        children: [
          //레시피 사진
          Image.network(
            thisRecipe.imageUrl,
            width: appSize.width, //앱 화면 가로 = 사진 가로
            height: 250,
            fit:BoxFit.cover, //박스 꽉 채우기
          ),
          //레시피 소개
          titleSection,
          //레시피 정보 영역
          iconSection,
          //재료 정보 영역
          ingredientSection(thisRecipe),
          //조리 순서 영역
          stepSection,
      ],
      ),
    );
  } //Widget
} //class _RecipeDetailScreenState
