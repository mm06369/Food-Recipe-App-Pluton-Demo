import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/components/recipe_card.dart';
import 'package:food_recipe_app/pages/saved_recipe_page.dart';
import 'package:get/get.dart';
import '../data/search_controller.dart';

class HomepageScreen extends StatelessWidget {
  HomepageScreen({super.key});

  final SearchControllerr controller = Get.put(SearchControllerr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.to(() => SavedRecipesPage()); // Navigate using GetX
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Discover Recipes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  controller.searchText.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter keywords, ingredients, or diet...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("search button pressed");
                      controller.performSearch();
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.recipesList.isEmpty) {
                    return Center(child: Text("No results found", style: TextStyle(color: Colors.grey)));
                  } else {
                    return ListView.builder(
                      itemCount: controller.recipesList.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(recipe: controller.recipesList[index]);
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
