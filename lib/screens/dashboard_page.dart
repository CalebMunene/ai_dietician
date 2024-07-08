import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'meal_logging_page.dart';
import 'progress_page.dart';

class DashboardPage extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: FutureBuilder(
        future: _apiService.getRecommendation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: <Widget>[
                Text('Recommendation: ${snapshot.data}'),
                ElevatedButton(
                  child: Text('Log Meal'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MealLoggingPage()));
                  },
                ),
                ElevatedButton(
                  child: Text('View Progress'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressPage(seriesList: [], animate: false)));
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
