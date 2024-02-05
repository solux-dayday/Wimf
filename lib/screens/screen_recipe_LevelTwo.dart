import 'package:flutter/material.dart';
import 'package:wimf/models/recipe.dart';
import 'package:wimf/screens/screen_recipe_detail.dart';

class LevelTwoRecipeScreen extends StatelessWidget {
  const LevelTwoRecipeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        // recipeList에서 레벨 값이 1인 아이템만 필터링
        recipeList.where((item) => item.level == 2).length,
            (index) {
          // 레벨 값이 1인 아이템에 대한 인덱스 계산
          int originalIndex = recipeList.indexWhere((item) => item.level == 2, index);

          return Container(
            height: 130.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(item: recipeList[originalIndex]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Image.asset(
                      "${recipeList[originalIndex].imageUrl}",
                      width: 130.0,
                      height: 130.0,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${recipeList[originalIndex].title}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                children: List.generate(
                                  recipeList[originalIndex].level,
                                      (starIndex) => Icon(
                                    Icons.star,
                                    color: Colors.blue,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < recipeList[originalIndex].ingredient.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "${recipeList[originalIndex].ingredient[i].name}",
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
          );
        },
      ),
    );
  }
}
