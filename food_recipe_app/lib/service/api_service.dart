import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/data/ingredient_model.dart';
import 'package:food_recipe_app/data/nutrient_model.dart';
import 'package:food_recipe_app/data/recipe_detail.dart';
import 'package:food_recipe_app/data/recipe_step.dart';
import 'package:food_recipe_app/data/recipe_model.dart';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseURL = "https://api.spoonacular.com/";
  static const String recipe = "recipes/";
  static const String complexSearch = "complexSearch";
  static const String apiKey = '70b3b3207a3e4c848f3d3b846fd770da';

  getRecipes({String? query, String? ingredients, String? diet}) async {
    try {
      var parameters = {'apiKey': apiKey, 'query': query};
      final response = await http.get(
          Uri.parse('$baseURL$recipe$complexSearch').replace(queryParameters: parameters));
      if (response.statusCode == 200) {
        debugPrint('getRecipes api fetched successfully');
        final jsonResult = jsonDecode(response.body)['results'] as List; 
        final List<Recipe> recipes = jsonResult.map((recipe) => Recipe.fromJson(recipe)).toList();
        return recipes;
      }
      else{
        debugPrint("getRecipes api statuscode: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching the getRecipes api: ${e.toString()}");
      rethrow;
    }
    return [];
  }


  Future<List<Nutrient>> getNutrition(int id) async {
    try{
      final response = await http.get(Uri.parse('$baseURL$recipe$id/nutritionWidget.json').replace(queryParameters: {'apiKey':apiKey}));
      if (response.statusCode == 200){
        final jsonData = jsonDecode(response.body)['nutrients'] as List;
        final nutrientsLst = jsonData.map((nutrient) => Nutrient.fromJson(nutrient)).toList();
        return nutrientsLst;
      }

    } catch (e){
      debugPrint("In getNutrition: ${e.toString()}");
    }
    return [];
  }

  Future<List<Ingredient>> getIngredients(int id) async {
    try{
      final response = await http.get(Uri.parse('$baseURL$recipe$id/ingredientWidget.json').replace(queryParameters: {'apiKey':apiKey}));
      if (response.statusCode == 200){
        final jsonData = jsonDecode(response.body)['ingredients'] as List;
        final ingredientsLst = jsonData.map((ingredient) => Ingredient.fromJson(ingredient)).toList();
        return ingredientsLst;
      }

    } catch (e){
      debugPrint("In getIngredients: ${e.toString()}");
    }
    return [];
  }

  Future<List<RecipeStep>> getRecipesInstruction(int id) async {
    try{
      final response = await http.get(Uri.parse('$baseURL$recipe$id/analyzedInstructions').replace(queryParameters: {'apiKey':apiKey}));
      if (response.statusCode == 200){
        final jsonData = jsonDecode(response.body) as List;
        final recipeSteps = jsonData.map((recipeStep) => RecipeStep.fromJson(recipeStep)).toList();
        print("recipesteps: ${recipeSteps[0].stepDescription}");
        return recipeSteps;
      }

    } catch (e){
      debugPrint("In getRecipesInstruction: ${e.toString()}");
    }
    return [];
  }

 Future<RecipeDetail> fetchAllRecipeDetails(int id) async {
  try {
    final Future<List<Nutrient>> nutrientsFuture = getNutrition(id);
    final Future<List<Ingredient>> ingredientsFuture = getIngredients(id);
    final Future<List<RecipeStep>> recipeStepsFuture = getRecipesInstruction(id);

    // Wait for all futures to complete
    final results = await Future.wait([
      nutrientsFuture,
      ingredientsFuture,
      recipeStepsFuture,
    ]);

    return RecipeDetail(
      nutrients: results[0] as List<Nutrient>,
      ingredients: results[1] as List<Ingredient>,
      recipeSteps: results[2] as List<RecipeStep>, 
    );
  } catch (e) {
    debugPrint("Error fetching recipe details: $e");
     throw Exception('Failed to fetch recipe details: $e');
  }
}
}

  
  
  

