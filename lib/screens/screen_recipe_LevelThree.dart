import 'package:flutter/material.dart';
import 'package:wimf/models/recipe.dart';
import 'package:wimf/models/recipe_provider.dart';
import 'package:wimf/screens/screen_recipe_detail.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class LevelThreeRecipeScreen extends StatefulWidget {
  const LevelThreeRecipeScreen({Key? key}) : super(key: key);

  @override
  _LevelThreeRecipeScreenState createState() => _LevelThreeRecipeScreenState();
}

class _LevelThreeRecipeScreenState extends State<LevelThreeRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    // Level 1인 레시피만 필터링
    final levelThreeRecipes = recipeProvider.recipe.where((recipe) => recipe.level == '3').toList();

    return Scaffold(
      body: recipeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: List.generate(
          levelThreeRecipes.length,
              (index) => Container(
            height: 130.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(item: levelThreeRecipes[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Image.network(
                      "${levelThreeRecipes[index].imageUrl}",
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
                                "${levelThreeRecipes[index].title}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                children: List.generate(
                                  min(5, int.parse(levelThreeRecipes[index].level)),
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
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 160.0,
                              maxHeight: 100,
                            ),
                            child: Wrap(
                              spacing: 0.0,
                              runSpacing: 5.0,
                              children: [
                                for (int i = 0; i < min(5, levelThreeRecipes[index].ingredient.length); i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      "${levelThreeRecipes[index].ingredient[i]}",
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                if (levelThreeRecipes[index].ingredient.length > 5)
                                  GestureDetector(
                                    onTap: () {
                                      // 더보기 기능 추가
                                      // 필요한 작업 수행
                                    },
                                    child: Text(
                                      "...",
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.blue),
                                    ),
                                  ),
                              ],
                            ),
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
      ),
    );
  }
}