import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/recipe_model.dart';
import 'package:food_recipe_app/pages/recipe_detail_page.dart';
import 'package:get/get.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => RecipeDetailsPage(recipeId: recipe.id));
      },
      child: Card(
        elevation: 4, // Minimalistic shadow effect
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image of the recipe
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                recipe.imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Text details of the recipe
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
