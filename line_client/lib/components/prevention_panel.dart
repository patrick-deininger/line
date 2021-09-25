import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:line_client/pages/exercising.dart';
import 'package:table_calendar/table_calendar.dart';

const Color kFancyBlue = Color(0xFF4C8BF5);

/// Example event class.
class ExerciseData {
  final String title;
  final bool isDone;
  final void Function(BuildContext context)? onTap;

  const ExerciseData({required this.title, this.onTap, this.isDone = false});

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kExercises = LinkedHashMap<DateTime, List<ExerciseData>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kExerciseSource);

final _kExerciseSource = Map.fromIterable(
  List.generate(50, (index) => index),
  key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  value: (item) => List.generate(
    item % 4 + 1,
    (index) => ExerciseData(title: 'Event $item | ${index + 1}', isDone: true),
  ),
)..addAll({
    kToday: [
      ExerciseData(title: 'World\'s Greatest Stretch'),
      ExerciseData(
        title: 'Squats',
        onTap: (context) => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ExercisingPage(),
          ),
        ),
      ),
    ]
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class PreventionPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PreventionPanelState();
}

class _PreventionPanelState extends State<PreventionPanel> {
  late final ValueNotifier<List<ExerciseData>> _selectedExercises;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedExercises = ValueNotifier(_getExercisesForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedExercises.dispose();
    super.dispose();
  }

  List<ExerciseData> _getExercisesForDay(DateTime day) {
    // Implementation example
    return kExercises[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedExercises.value = _getExercisesForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: kFancyBlue.withAlpha(64),
              shape: BoxShape.circle,
            ),
            markerMargin: EdgeInsets.symmetric(horizontal: 1.0),
          ),
          onDaySelected: _onDaySelected,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          eventLoader: _getExercisesForDay,
        ),
        const SizedBox(height: 8.0),
        ValueListenableBuilder<List<ExerciseData>>(
          valueListenable: _selectedExercises,
          builder: (context, value, _) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (_, index) => Exercise(data: value[index]),
            );
          },
        ),
      ],
    );
  }
}

class Exercise extends StatelessWidget {
  Exercise({required this.data});

  final ExerciseData data;

  Color getForegroundColor() =>
      data.isDone ? Colors.green.shade700 : Colors.blueAccent.shade400;

  Color getBackgroundColor() =>
      data.isDone ? Colors.green.shade50 : Colors.blue.shade50;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: getForegroundColor()),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ListTile(
          tileColor: getBackgroundColor(),
          onTap: () {
            if (data.onTap != null) {
              data.onTap!(context);
            }
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  color: getForegroundColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (data.isDone)
                Icon(
                  Icons.check_circle,
                  color: getForegroundColor(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
