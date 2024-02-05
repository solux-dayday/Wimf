import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wimf/widgets/recipe_widget.dart';
import 'package:wimf/screens/screen_recipe_total.dart';
import 'package:wimf/screens/screen_recipe_LevelOne.dart';
import 'package:wimf/screens/screen_recipe_LevelTwo.dart';
import 'package:wimf/screens/screen_recipe_LevelThree.dart';

class TabRecipes extends StatelessWidget{
  const TabRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
   List<String> levelRecipes = [
     "전체",
     "1단계",
     "2단계",
     "3단계",
     "북마크",
   ];

   return DefaultTabController(
     length: levelRecipes.length,
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         title: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 12), // 타이틀을 아래로 이동시킬 만큼의 여백
             Text(
               "단계별 레시피",
               style: TextStyle(color: Colors.white),
             ),
           ],
         ),
         bottom: PreferredSize(
           preferredSize: Size.fromHeight(kToolbarHeight),
           child: Container(
             color: Colors.white,
             child: TabBar(
               tabs: List.generate(
                 levelRecipes.length,
                     (index) => Tab(
                   text: levelRecipes[index],
                 ),
               ),
               unselectedLabelColor: Colors.black38,
               labelColor: Colors.blue,
               indicatorColor: Colors.blue,
               indicator: UnderlineTabIndicator(
                 borderSide: BorderSide(color: Colors.blue, width: 2.0),
               ),
             ),
           ),
         ),
       ),
       body: TabBarView(
         children: [
           Container(child: Center(child: TotalRecipeScreen())),
           Container(child: Center(child: LevelOneRecipeScreen())),
           Container(child: Center(child: LevelTwoRecipeScreen())),
           Container(child: Center(child: LevelThreeRecipeScreen())),
           Container(child: Center(child: Text("북마크 레시피입니다."))),
         ],
       ),
     ),
   );


  }
}

