import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/food_item_dropdown.dart';

class MealLoggingPage extends StatefulWidget {
  @override
  _MealLoggingPageState createState() => _MealLoggingPageState();
}

class _MealLoggingPageState extends State<MealLoggingPage> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  String mealType = 'Carbohydrates';
  String foodItem = 'Ugali';
  int calories = 0;

  final List<String> mealTypes = ['Carbohydrates', 'Proteins', 'Vitamins'];
  final Map<String, List<String>> foodItems = {
    'Carbohydrates': [
      'Ugali',
      'Rice',
      'Chapati',
      'Githeri',
      'Irio',
      'Mukimo',
      'Matoke',
      'Mandazi',
      'Roasted Maize'
    ],
    'Proteins': [
      'Nyama Choma',
      'Fish',
      'Beans and Legumes',
      'Milk',
      'Fermented Milk',
      'Cheese',
      'Mutura',
      'Samosas'
    ],
    'Vitamins': [
      'Sukuma Wiki',
      'Spinach',
      'Cabbage',
      'Managu',
      'Terere',
      'Mangoes',
      'Papayas',
      'Bananas',
      'Pineapples',
      'Avocados',
      'Passion Fruit',
      'Oranges',
      'Kachumbari',
      'Juices',
      'Mursik'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log Meal')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            FoodItemDropdown(
              foodItems: mealTypes,
              selectedItem: mealType,
              onChanged: (String? value) {
                setState(() {
                  mealType = value!;
                  foodItem = foodItems[mealType]![0];
                });
              },
            ),
            FoodItemDropdown(
              foodItems: foodItems[mealType]!,
              selectedItem: foodItem,
              onChanged: (String? value) {
                setState(() => foodItem = value!);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
              validator: (String? val) => val!.isEmpty ? 'Enter calories' : null,
              onChanged: (String val) {
                setState(() => calories = int.tryParse(val) ?? 0);
              },
            ),
            ElevatedButton(
              child: Text('Log Meal'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _apiService.logMeal({
                    'meal_type': mealType,
                    'food_item': foodItem,
                    'calories': calories,
                    'timestamp': DateTime.now().toIso8601String()
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
