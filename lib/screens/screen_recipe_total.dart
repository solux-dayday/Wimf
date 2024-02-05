//전체 레시피 리스트 화면

import 'package:flutter/material.dart';
import 'package:wimf/models/recipe.dart';
import 'package:wimf/screens/screen_recipe_detail.dart';
import 'dart:math';

class TotalRecipeScreen extends StatelessWidget{
  const TotalRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListView(
      children: List.generate(
          recipeList.length, //recipeList 길이 만큼 리스트 만듦
              (index) => Container(
                height: 130.0,//메뉴 목록 높이 지정 : 130
                  //리스트뷰의 아이템이 클릭시
                child : GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) => RecipeDetailScreen(item:recipeList[index]),
                    ));
                  },
                child: Padding( //여백
                  padding: const EdgeInsets.all(0.0),
                child: Row(//위젯 수평 방향 배치
                  children: [
                    //메뉴 이미지
                    Image.asset("${recipeList[index].imageUrl}",
                      width: 130.0, // 이미지의 너비를 원하는 크기로 조정
                      height: 130.0, // 이미지의 높이를 원하는 크기로 조정
                      fit: BoxFit.cover, // 이미지의 비율을 유지하면서 이미지를 모두 표시
                    ),
                    //메뉴명과 재료
                    Padding(padding: const EdgeInsets.all(10.0), //이미지와 글자 사이 패딩
                    child : Column(
                      mainAxisAlignment: MainAxisAlignment.center,//수직방향 중앙정렬
                      crossAxisAlignment: CrossAxisAlignment.start, //가로방향 왼쪽 맞춤 정렬
                      children: [
                        // Row를 사용하여 타이틀과 난이도에 따른 별 아이콘을 가로로 배열
                        Row(
                          children: [
                            // 메뉴명
                            Text(
                              "${recipeList[index].title}",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),

                            // 난이도에 따라 별 아이콘을 가로로 배치
                            Row(
                              children: List.generate(
                                recipeList[index].level,
                                    (starIndex) => Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                  size: 20.0, // 별 아이콘의 크기 조절
                                ),
                              ),
                            ),
                          ],
                        ),

                        //title과 ingredient 사이 간격
                        SizedBox(height: 10),

                        //재료
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int i=0; i < recipeList[index].ingredient.length ; i++)
                            Padding(padding: const EdgeInsets.only(right: 5.0),
                            child: Text("${recipeList[index].ingredient[i].name}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            )
                          ],
                        ),
                      ],
                    ),
                    ),
                  ],
              ),
              ),
              ),
              ),
     ),
    );
  }
   }

