// lib/pages/calendar_page.dart
import 'package:flutter/material.dart';

import '../widgets/add_item_dialog.dart';
import '../widgets/custom_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxW = screenSize.width * 0.9;
    final maxH = screenSize.height * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hability', style: TextStyle(fontFamily: 'Milkyway')),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
          child: CustomCalendar(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            onDaySelected: _onDaySelected,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddItemDialog(),
          );
        },
        tooltip: 'Add Item',
        backgroundColor: const Color(0xFF6C0E11), // Button color
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
