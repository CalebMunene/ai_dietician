import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://your-flask-server-url';

  Future<String> getRecommendation() async {
    final response = await http.post(
      Uri.parse('$baseUrl/get_recommendation'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'age': 30,
        'gender': 'Male',
        'weight': 70,
        'height': 175,
        'activity_level': 'Moderate Activity',
        'dietary_preference': 'Omnivorous',
        'health_goal': 'Maintenance'
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['recommendation'];
    } else {
      throw Exception('Failed to get recommendation');
    }
  }

  Future<void> logMeal(Map<String, dynamic> mealData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/log_meal'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(mealData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log meal');
    }
  }
}
