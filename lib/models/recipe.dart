import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe{
  late String level; //난이도
  late String title; //요리 이름
  late List<String> ingredient; //재료
  late List food_amount; //재료별 양
  late List food_unit; //재료별 단위
  late String imageUrl; //이미지
  late String explain; //요리 소개
  late String peoplenum; //몇인분
  late String maketime; //조리시간
  late List<String> steps; //조리법

  Recipe({
    required this.level,
    required this.title,
    required this.ingredient,
    required this.food_amount,
    required this.food_unit,
    required this.imageUrl,
    required this.explain,
    required this.peoplenum,
    required this.maketime,
    required this.steps,
  });

  Recipe.fromSnapshot(DocumentSnapshot snapshot){
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    level = data['level'];
    title = data['title'];
    ingredient = (data['ingredient'] as List<dynamic>).cast<String>();
    food_amount = data['food_amount'] as List<dynamic>;
    food_unit = data['food_unit'] as List<dynamic>;
    imageUrl = data['imageUrl'];
    explain = data['explain'];
    peoplenum = data['peoplenum'];
    maketime = data['maketime'];
    steps = (data['steps'] as List<dynamic>).cast<String>();
  }
}



// List<Recipe> recipeList = [
//   Recipe(
//     level: 1,
//     title:"김치찌개",
//     ingredient : ["김치", "돼지고기","기타등등", "아몰랑호호호", "아몰랑호호호","아몰랑호호호","아몰랑호호호","아몰랑호호호",],
//     food_amount: ["1", "1/2", "30", "0.3","","","","",""],
//     food_unit: ["포기", "근", "T", "g","","","","",""],
//     imageUrl : "assets/images/food_01.jpg",
//     explain : "오늘은 요즘 대세! 주부들의 로망!! 백종원님의 김치찌개에 도전해 봤어요~ 간단하면서도 자주해먹을수 있는 백종원님표 김치찌개!!!",
//     peoplenum : "2인분",
//     maketime : "60분 이내",
//     steps : ["쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째를 사용하셔야 좋아요^^ 파는1/2를 준비해주세요.",
//     "아 몰라 맛있게 만들어주세요", "쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째", "쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째", "쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째","쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째"],
//   ),
//   Recipe(
//     level: 2,
//     title:"핫도그",
//     ingredient : ["김치", "돼지고기","기타등등", "아몰랑호호호", "아몰랑호호호","아몰랑호호호","아몰랑호호호","아몰랑호호호",],
//     food_amount: ["1", "1/2", "30", "0.3","","","","",""],
//     food_unit: ["포기", "근", "T", "g","","","","",""],
//     imageUrl : "assets/images/food_02.jpg",
//     explain : "오늘은 요즘 대세! 주부들의 로망!! 백종원님의 김치찌개에 도전해 봤어요~ 간단하면서도 자주해먹을수 있는 백종원님표 김치찌개!!!",
//     peoplenum : "2인분",
//     maketime : "60분 이내",
//     steps : ["1. 쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째를 사용하셔야 좋아요^^ 파는1/2를 준비해주세요."],
//   ),
//   Recipe(
//     level: 1,
//     title:"된장찌개",
//     ingredient : ["김치", "돼지고기","기타등등", "아몰랑호호호", "아몰랑호호호","아몰랑호호호","아몰랑호호호","아몰랑호호호",],
//     food_amount: ["1", "1/2", "30", "0.3","","","","",""],
//     food_unit: ["포기", "근", "T", "g","","","","",""],
//     imageUrl : "assets/images/food_03.jpg",
//     explain : "오늘은 요즘 대세! 주부들의 로망!! 백종원님의 김치찌개에 도전해 봤어요~ 간단하면서도 자주해먹을수 있는 백종원님표 김치찌개!!!",
//     peoplenum : "2인분",
//     maketime : "60분 이내",
//     steps : ["1. 쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째를 사용하셔야 좋아요^^ 파는1/2를 준비해주세요."],
//   ),
//   Recipe(
//     level: 3,
//     title:"마카롱",
//     ingredient : ["김치", "돼지고기","기타등등", "아몰랑호호호", "아몰랑호호호","아몰랑호호호","아몰랑호호호","아몰랑호호호",],
//     food_amount: ["1", "1/2", "30", "0.3","","","","",""],
//     food_unit: ["포기", "근", "T", "g","","","","",""],
//     imageUrl : "assets/images/food_04.jpg",
//     explain : "오늘은 요즘 대세! 주부들의 로망!! 백종원님의 김치찌개에 도전해 봤어요~ 간단하면서도 자주해먹을수 있는 백종원님표 김치찌개!!!",
//     peoplenum : "2인분",
//     maketime : "60분 이내",
//     steps : ["1. 쌀뜨물을 이용해서 김치찌개를 만들거예요^^ 쌀뜨물은 첫번째 물이 아닌 2번째난 3번째를 사용하셔야 좋아요^^ 파는1/2를 준비해주세요."],
//   ),
//
// ];