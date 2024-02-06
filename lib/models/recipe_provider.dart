import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeProvider with ChangeNotifier {
  late CollectionReference recipeReference;
  List<Recipe> recipe = [];
  bool isLoading = false;

  RecipeProvider({reference}) {
    recipeReference = reference ?? FirebaseFirestore.instance.collection('RECIPE');
    fetchItems(); // initState에서 호출하지 않도록 변경
  }

  Future<void> fetchItems() async {
    isLoading = true;
    notifyListeners();

    recipe = await recipeReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Recipe.fromSnapshot(document);
      }).toList();
    });

    isLoading = false;
    // notifyListeners(); // 여기서는 호출하지 않음
  }
}