import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList; // Corrected type
  final bool animate;

  ProgressChart({required this.seriesList, required this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}
