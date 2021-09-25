// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

List<Activity> activityFromJson(String str) =>
    List<Activity>.from(json.decode(str).map((x) => Activity.fromJson(x)));

String activityToJson(List<Activity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activity {
  Activity({
    required this.id,
    required this.externalId,
    required this.source,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.duration,
    required this.amount,
    required this.unit,
    required this.calories,
    required this.distance,
    required this.steps,
  });

  String id;
  String externalId;
  Source source;
  UserId userId;
  Date startDate;
  Date endDate;
  Type type;
  int duration;
  dynamic amount;
  dynamic unit;
  int calories;
  double distance;
  int steps;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        externalId: json["externalId"],
        source: sourceValues.map[json["source"]] ?? Source.FORERUNNER_745,
        userId: userIdValues.map[json["userId"]] ??
            UserId.THE_614_F0_B479187_A32_FF33_D0_B18,
        startDate: Date.fromJson(json["startDate"]),
        endDate: Date.fromJson(json["endDate"]),
        type: typeValues.map[json["type"]] ?? Type.CYCLING,
        duration: json["duration"],
        amount: json["amount"],
        unit: json["unit"],
        calories: json["calories"],
        distance: json["distance"].toDouble(),
        steps: json["steps"] == null ? 0 : json["steps"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "externalId": externalId,
        "source": sourceValues.reverse[source],
        "userId": userIdValues.reverse[userId],
        "startDate": startDate.toJson(),
        "endDate": endDate.toJson(),
        "type": typeValues.reverse[type],
        "duration": duration,
        "amount": amount,
        "unit": unit,
        "calories": calories,
        "distance": distance,
        "steps": steps == null ? 0 : steps,
      };
}

class Date {
  Date({
    required this.date,
    required this.time,
  });

  DateClass date;
  Time time;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: DateClass.fromJson(json["date"]),
        time: Time.fromJson(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toJson(),
        "time": time.toJson(),
      };
}

class DateClass {
  DateClass({
    required this.year,
    required this.month,
    required this.day,
  });

  int year;
  int month;
  int day;

  factory DateClass.fromJson(Map<String, dynamic> json) => DateClass(
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

class Time {
  Time({
    required this.hour,
    required this.minute,
    required this.second,
  });

  int hour;
  int minute;
  int second;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
        "second": second,
      };
}

enum Source { FORERUNNER_745 }

final sourceValues = EnumValues({"Forerunner 745": Source.FORERUNNER_745});

class Type {
  const Type({required this.name});

  final String name;

  static const Type RUNNING = Type(name: "Running");
  static const Type CYCLING = Type(name: "Cycling");
  static const Type SWIMMING = Type(name: "Swimming");
}

final typeValues = EnumValues({
  "Cycling": Type.CYCLING,
  "Running": Type.RUNNING,
  "Swimming": Type.SWIMMING
});

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
