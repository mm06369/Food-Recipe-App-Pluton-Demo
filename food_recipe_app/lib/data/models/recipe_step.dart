class RecipeStep {
  final String stepDescription;

  RecipeStep({required this.stepDescription});

  factory RecipeStep.fromJson(Map<String, dynamic> json) {
    return RecipeStep(
      stepDescription: json['step'] ?? ""
    );
  }
}
