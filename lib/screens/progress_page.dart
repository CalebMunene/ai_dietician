import 'package:flutter/material.dart';
import '../widgets/progress_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressPage extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  ProgressPage({required this.seriesList, this.animate = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: ProgressChart(seriesList: seriesList, animate: animate),
    );
  }
}
