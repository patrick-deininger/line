// To parse this JSON data, do
//
//     final dailyActivities = dailyActivitiesFromJson(jsonString);

import 'dart:convert';

List<DailyActivity> dailyActivitiesFromJson(String str) =>
    List<DailyActivity>.from(
        json.decode(str).map((x) => DailyActivity.fromJson(x)));

String dailyActivitiesToJson(List<DailyActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyActivity {
  DailyActivity({
    required this.userId,
    required this.date,
    required this.points,
    required this.calories,
    required this.steps,
    required this.distance,
    required this.activityMinutes,
  });

  UserId userId;
  Date date;
  int points;
  int calories;
  int steps;
  int distance;
  int activityMinutes;

  factory DailyActivity.fromJson(Map<String, dynamic> json) => DailyActivity(
        userId: userIdValues.map[json["userId"]]!,
        date: Date.fromJson(json["date"]),
        points: json["points"],
        calories: json["calories"],
        steps: json["steps"],
        distance: json["distance"],
        activityMinutes: json["activityMinutes"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userIdValues.reverse[userId],
        "date": date.toJson(),
        "points": points,
        "calories": calories,
        "steps": steps,
        "distance": distance,
        "activityMinutes": activityMinutes,
      };
}

class Date {
  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  int year;
  int month;
  int day;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        year: json["year"],
        month: json["month"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
      };
}

enum UserId { THE_614_F0_B479187_A32_FF33_D0_B18 }

final userIdValues = EnumValues(
    {"614f0b479187a32ff33d0b18": UserId.THE_614_F0_B479187_A32_FF33_D0_B18});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
