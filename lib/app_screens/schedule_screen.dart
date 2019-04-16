import 'package:flutter/material.dart';
import 'package:mextv_app/components/mex_app_bar.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("Schedule"),
      body: Container(
        child: Center(child: Text("Schedules")),
      ),
    );
  }
}
