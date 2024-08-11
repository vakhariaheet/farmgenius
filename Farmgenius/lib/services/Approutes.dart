import 'package:demo/screens/daily_report.dart';
import 'package:demo/screens/report_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static const String home = '/';
  static const String soilReport = '/soil_report';
  static const String dailyReport = '/daily_report';

  static const String notfound = '*';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      soilReport: (context) => const ReportInfo(),
      dailyReport: (context) => const DailyReport(),
     
      notfound: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
    };
  }
}
