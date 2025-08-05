// lib/main.dart
import 'package:flutter/material.dart';

import 'pages/calendar_page.dart';

void main() {
  runApp(const Hability());
}

class Hability extends StatelessWidget {
  const Hability({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const CalendarPage(),
    );
  }
}
