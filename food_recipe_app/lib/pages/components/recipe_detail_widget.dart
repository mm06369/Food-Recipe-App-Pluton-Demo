import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/database_helper.dart';
import 'package:food_recipe_app/data/ingredient_model.dart';
import 'package:food_recipe_app/data/nutrient_model.dart';
import 'package:food_recipe_app/data/recipe_detail.dart';
import 'package:food_recipe_app/data/recipe_step.dart';

class RecipeDetailWidget extends StatelessWidget {
  final RecipeDetail recipeDetail;

  RecipeDetailWidget({required this.recipeDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.save, size: 30,),
              onPressed: () async {
                // Example save function
                await DBHelper.saveRecipe(recipeDetail.recipeInfo.id, recipeDetail.recipeInfo.title, recipeDetail.recipeInfo.imageUrl);
                if (context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recipe saved!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.zero,
            child: Image.network(recipeDetail.recipeInfo.imageUrl)),
          SizedBox(height: 16.0),
          Text(
            recipeDetail.recipeInfo.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          SectionTitle(title: 'Ingredients'),
          SizedBox(height: 8.0),
          IngredientList(ingredients: recipeDetail.ingredients),
          SizedBox(height: 16.0),
          SectionTitle(title: 'Nutrients'),
          SizedBox(height: 8.0),
          NutrientList(nutrients: recipeDetail.nutrients),
          SizedBox(height: 16.0),
          SectionTitle(title: 'Recipe Steps'),
          SizedBox(height: 8.0),
          RecipeStepList(recipeSteps: recipeDetail.recipeSteps),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;

  IngredientList({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredients.map((ingredient) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              '- ${ingredient.amount.metric.value} ${ingredient.amount.metric.unit} ${ingredient.name}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NutrientList extends StatelessWidget {
  final List<Nutrient> nutrients;

  NutrientList({required this.nutrients});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nutrients.map((nutrient) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              '- ${nutrient.name}: ${nutrient.amount} ${nutrient.unit} (${nutrient.percentOfDailyNeeds}% of Daily Needs)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class RecipeStepList extends StatelessWidget {
  final List<RecipeStep> recipeSteps;

  RecipeStepList({required this.recipeSteps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: recipeSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            '${index + 1}. ${step.stepDescription}',
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }
}