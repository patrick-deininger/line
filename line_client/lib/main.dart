import 'package:flutter/material.dart';
import 'package:line_client/pages/home.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(
    Uri.parse(
        'https://api.fitrockr.com/v1/users/614f0b479187a32ff33d0b18/dailySummaries?startDate=2021-07-21&endDate=2021-09-21'),
    // Send authorization headers to the backend.
    headers: {
      'X-API-Key': '28fd51c7-df6d-45f8-9cc1-817481a11967',
      'X-Tenant': 'hackzurich'
    },
  );
  final List apiResponse = jsonDecode(response.body);

  // Map<String, int> activeMap = {};

  // for (var i = 0; i < responseJson.length; i++) {
  //   final val = responseJson[i];

  //   if (val["type"] != null &&
  //       val["duration"] != null &&
  //       activeMap[val["type"]] != null) {
  //     activeMap[val["type"]] =
  //         (val["duration"] as int) ~/ 60 + (activeMap[val["type"]] ?? 0);
  //   } else {
  //     activeMap[val["type"]] = (val["duration"] as int) ~/ 60;
  //   }
  // }

  runApp(LineClient(apiResponse));
}

class LineClient extends StatelessWidget {
  LineClient(this.apiResponse);

  final List apiResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Line',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(apiResponse),
    );
  }
}
