import 'package:flutter/cupertino.dart';
import 'package:food_recipe_app/data/recipe_model.dart';
import 'package:food_recipe_app/service/api_service.dart';
import 'package:get/get.dart';

class SearchControllerr extends GetxController {
  var searchText = ''.obs;
  final apiService = APIService();
  var isLoading = false.obs;
  var recipesList = <Recipe>[].obs;

  performSearch() async {
    isLoading(true);
    debugPrint("perfromSearch called");
    try {
      final res = await apiService.getRecipes(query: searchText.value);
      recipesList.value = res;
    } catch (e) {
      debugPrint("in performSearch: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
