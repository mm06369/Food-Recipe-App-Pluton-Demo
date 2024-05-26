# Food Recipe App

## Overview

Foodie Recipe App is a mobile application designed to help users discover food recipes based on their preferences, dietary restrictions, or nutritional needs. Leveraging the Spoonacular API, the app provides a vast database of recipes to explore, save, and enjoy.

## Features

- **Search Functionality**: Users can search for recipes by entering keywords, dietary options, or specific nutrient requirements.

- **Recipe Cards**: Search results are displayed as interactive cards, providing a glimpse of each recipe's details, including an image, title, and brief description.

- **Recipe Details**: Upon selecting a recipe card, users can view comprehensive details about the chosen recipe, including ingredients, preparation steps, cooking time, and nutritional information.

- **Save for Later**: Users can save their favorite recipes to access them later conveniently.

## Technologies Used

- **Spoonacular API**: The app utilizes the Spoonacular API to fetch food recipes based on user queries.

- **Flutter**: Developed using the Flutter framework for building cross-platform mobile applications.

- **Getx**: State management is handled efficiently using get, ensuring a seamless user experience.

- **SQFlite Database**: Saved recipes are stored locally using SQFLite, allowing users to access their saved recipes even when offline.

## Installation

1. Clone the repository: `git clone https://github.com/mm06369/Food-Recipe-App-Pluton-Demo.git`
2. Navigate to the project directory: `cd food_recipe_app`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Configuration

To use the Spoonacular API, you need to obtain an API key from the Spoonacular website (https://spoonacular.com/food-api). Once you have the API key, and add it in api_service.dart file inside lib/service directory


## Usage

1. Launch the app on your mobile device or emulator.
2. Use the search bar to enter keywords, dietary preferences, or nutrient requirements.
3. Browse through the search results displayed as recipe cards.
4. Click on a recipe card to view detailed information about the selected recipe.
5. To save a recipe for later, use the provided option within the recipe details page.

## Contributing

Contributions are welcome! If you encounter any bugs, have feature requests, or want to contribute enhancements, feel free to open an issue or submit a pull request.

## Acknowledgements

- Spoonacular for providing the comprehensive food API.
- Flutter community for the powerful framework.
- Getx for efficient state management.


