import 'package:food_recipe_app/data/ingredient_model.dart';
import 'package:food_recipe_app/data/nutrient_model.dart';
import 'package:food_recipe_app/data/recipe_model.dart';
import 'package:food_recipe_app/data/recipe_step.dart';

class RecipeDetail {
  final List<Nutrient> nutrients;
  final List<Ingredient> ingredients;
  final List<RecipeStep> recipeSteps;
  final Recipe  recipeInfo;

  RecipeDetail({
    required this.nutrients,
    required this.ingredients,
    required this.recipeSteps,
    required this.recipeInfo
  });
}
