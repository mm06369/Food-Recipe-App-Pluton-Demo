import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/database_helper.dart';
import 'package:food_recipe_app/data/recipe_detail.dart';
import 'package:food_recipe_app/data/recipe_step.dart';
import 'package:food_recipe_app/pages/recipe_detail_widget.dart';
import 'package:food_recipe_app/service/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailsPage extends StatelessWidget {
  final int recipeId;
  final APIService _apiService =
      APIService(); 

  RecipeDetailsPage({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Recipe Details"), 
      ),
      body: FutureBuilder<RecipeDetail>(
  future: _apiService.fetchAllRecipeDetails(recipeId),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Text("Failed to load data: ${snapshot.error}");
    } else if (snapshot.hasData) {
      return RecipeDetailWidget(recipeDetail: snapshot.data!); // Implement this function based on your UI design
    } else {
      return Center(child: Text("No data available"));
    }
  },
)
    );
  }

}
