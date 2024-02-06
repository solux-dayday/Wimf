//전체 레시피 리스트 화면

import 'package:flutter/material.dart';
import 'package:wimf/models/recipe.dart';
import 'package:wimf/models/recipe_provider.dart';
import 'package:wimf/screens/screen_recipe_detail.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class TotalRecipeScreen extends StatefulWidget {
  const TotalRecipeScreen({Key? key}) : super(key: key);

  @override
  _TotalRecipeScreenState createState() => _TotalRecipeScreenState();
}

class _TotalRecipeScreenState extends State<TotalRecipeScreen> {
  @override
  void initState() {
    super.initState();
    // TotalRecipeScreen 위젯이 처음 빌드될 때 한 번만 데이터를 가져옴
    // Provider.of<RecipeProvider>(context, listen: false).fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      body: recipeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: List.generate(
          recipeProvider.recipe.length,
              (index) => Container(
            height: 130.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(item: recipeProvider.recipe[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Image.network(
                      "${recipeProvider.recipe[index].imageUrl}",
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
                                "${recipeProvider.recipe[index].title}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Row(
                                children: List.generate(
                                  min(5, int.parse(recipeProvider.recipe[index].level)),
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
                                for (int i = 0; i < min(5, recipeProvider.recipe[index].ingredient.length); i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      "${recipeProvider.recipe[index].ingredient[i]}",
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ),
                                if (recipeProvider.recipe[index].ingredient.length > 5)
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