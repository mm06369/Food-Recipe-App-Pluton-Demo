import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/database_helper.dart';
import 'package:food_recipe_app/data/recipe_model.dart';
import 'package:food_recipe_app/pages/components/recipe_card.dart';

class SavedRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Recipes"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DBHelper.getSavedRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipeData = snapshot.data![index];
                return Dismissible(
                  key: Key(recipeData['id'].toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await DBHelper.deleteRecipe(recipeData['id']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Recipe deleted")),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: RecipeCard(
                    recipe: Recipe(
                      id: recipeData['id'],
                      title: recipeData['title'],
                      imageUrl: recipeData['imageUrl'],
                      imageType: 'jpg',
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No saved recipes found"));
          }
        },
      ),
    );
  }
}
