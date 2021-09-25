import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:line_client/utils/activity_api.dart';
import 'indicator.dart';

const List<Color> kColors = [
  Color(0xfff8b250),
  Color(0xff845bef),
  Color(0xff13d38e),
  Color(0xff0293ee),
];

class AccumulatedActivity {
  AccumulatedActivity({required this.name, this.durationMinutes = 0});

  String name;
  int durationMinutes;
}

class ActivityChart extends StatefulWidget {
  ActivityChart(this.activities) {
    accumulatedActivities = getAccumulatedActivities();
  }

  final List<Activity> activities;
  List<AccumulatedActivity> accumulatedActivities = [];

  List<AccumulatedActivity> getAccumulatedActivities() {
    Map<Type, AccumulatedActivity> result = {};

    for (final Activity activity in this.activities) {
      final durationMinutes = activity.duration ~/ 60;

      if (result.containsKey(activity.type)) {
        result[activity.type]?.durationMinutes += durationMinutes;
      } else {
        result[activity.type] = AccumulatedActivity(
            name: activity.type.name, durationMinutes: durationMinutes);
      }
    }

    return result.values.toList();
  }

  @override
  State<StatefulWidget> createState() => _ActivityChartState();
}

class _ActivityChartState extends State<ActivityChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.accumulatedActivities.isEmpty) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: getData()),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.accumulatedActivities
                .map<Widget>(
                  (e) => Column(
                    children: [
                      Indicator(
                        color: kColors[widget.accumulatedActivities.indexOf(e)],
                        text: e.name,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                )
                .toList(),

            // const <Widget>[
            //   Indicator(
            //     color: Color(0xff0293ee),
            //     text: 'Sleep',
            //     isSquare: true,
            //   ),
            //   SizedBox(
            //     height: 4,
            //   ),
            //   Indicator(
            //     color: Color(0xfff8b250),
            //     text: 'Cycling',
            //     isSquare: true,
            //   ),
            //   SizedBox(
            //     height: 4,
            //   ),
            //   Indicator(
            //     color: Color(0xff845bef),
            //     text: 'Running',
            //     isSquare: true,
            //   ),
            //   SizedBox(
            //     height: 4,
            //   ),
            //   Indicator(
            //     color: Color(0xff13d38e),
            //     text: 'Swimming',
            //     isSquare: true,
            //   ),
            //   SizedBox(
            //     height: 18,
            //   ),
            // ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getData() {
    final temp = widget.accumulatedActivities
        .asMap()
        .map((index, element) {
          final isTouched = index == touchedIndex;
          final fontSize = isTouched ? 16.0 : 12.0;
          final radius = isTouched ? 60.0 : 50.0;

          return MapEntry(
              index,
              PieChartSectionData(
                color: kColors[index],
                value: element.durationMinutes.toDouble(),
                title: element.name,
                radius: radius,
                titleStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff)),
              ));
        })
        .values
        .toList();
    return temp;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
