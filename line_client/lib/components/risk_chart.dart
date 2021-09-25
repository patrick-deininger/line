import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class RiskChart extends StatefulWidget {
  RiskChart(this.apiResponse);

  final List apiResponse;

  @override
  _RiskChartState createState() => _RiskChartState(this.apiResponse);
}

class _RiskChartState extends State<RiskChart> {
  _RiskChartState(this.apiResponse);

  final List apiResponse;

  List<Color> gradientColors1 = [
    Colors.blue.shade500,
    Colors.blue.shade700,
  ];

  List<Color> gradientColors2 = [
    Colors.yellow.shade400,
    Colors.orange.shade300,
  ];

  List<Color> gradientColors3 = [
    Colors.purple.shade900,
    Colors.purple.shade800,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            AspectRatio(
              aspectRatio: 1.70,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 18.0, left: 12.0, top: 24, bottom: 12),
                  child: LineChart(mainData()),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Indicator(
                  color: Colors.blue.shade600,
                  text: 'Fitness',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.yellow.shade400,
                  text: 'Load',
                  isSquare: true,
                ),
                Indicator(
                  color: Colors.purple.shade900,
                  text: 'Risk',
                  isSquare: true,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  LineChartData mainData() {
    List<int> dailyVal = [];
    for (var day in apiResponse) {
      dailyVal.add(day["activityMinutes"]);
    }

    var reversedList = new List<int>.from(dailyVal.reversed);

    List<double> loadList = [];
    List<double> fitnessList = [];
    for (var i = 0; i < 20; i++) {
      loadList
          .add(reversedList.sublist(i, i + 3).reduce((a, b) => a + b) * 1.0);
      fitnessList.add(reversedList.sublist(i, i + 3).reduce((a, b) => a + b) *
              3 /
              7 +
          reversedList.sublist(i + 3, i + 7).reduce((a, b) => a + b) * 4 / 7);
    }

    List<FlSpot> loadSpots = [];
    List<FlSpot> fitnessSpots = [];
    List<FlSpot> riskSpots = [];
    for (var i = 0; i < 20; i++) {
      loadSpots.add(FlSpot(i.toDouble() / 1.75, loadList[i] / 300));
      fitnessSpots.add(FlSpot(i.toDouble() / 1.75, fitnessList[i] / 300));
      riskSpots.add(
          FlSpot(i.toDouble() / 1.75, (loadList[i] / fitnessList[i]) * 2 + 1));
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(strokeWidth: 0);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '10.09.';
              case 5:
                return '15.09.';
              case 8:
                return '20.09.';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Low Risk';
              // case 3:
              //   return '600';
              case 5:
                return 'High Risk';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300, width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: fitnessSpots,
          isCurved: true,
          colors: gradientColors1,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors1.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
        LineChartBarData(
          spots: loadSpots,
          isCurved: true,
          colors: gradientColors2,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
        LineChartBarData(
          spots: riskSpots,
          isCurved: true,
          colors: gradientColors3,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
