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
                var recipe = Recipe(
                  id: snapshot.data![index]['id'],
                  title: snapshot.data![index]['title'],
                  imageUrl: snapshot.data![index]['imageUrl'],
                  imageType: 'jpg',
                );
                return Dismissible(
                  key: Key(recipe.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await DBHelper.deleteRecipe(recipe.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${recipe.title} deleted"))
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: RecipeCard(recipe: recipe),
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
