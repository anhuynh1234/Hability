// lib/widgets/custom_calendar.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

typedef DaySelectedCallback =
    void Function(DateTime selectedDay, DateTime focusedDay);

class CustomCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final DaySelectedCallback onDaySelected;

  const CustomCalendar({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.onDaySelected,
  });

  String _getFormattedDisplayDate() {
    final displayDate = selectedDay ?? focusedDay;
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final w = weekdays[displayDate.weekday - 1];
    final m = months[displayDate.month - 1];
    final y = displayDate.year;
    return '$w, $m ${displayDate.day}, $y';
  }

  ButtonStyle _outlineDateButtonStyle() {
    return OutlinedButton.styleFrom(
      side: const BorderSide(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _getFormattedDisplayDate();

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        // Display the current or selected date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: OutlinedButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDay ?? focusedDay,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                helpText: 'Select a Date',
              );
              if (picked != null) {
                onDaySelected(picked, picked);
              }
            },
            style: _outlineDateButtonStyle(),
            child: Text(
              formattedDate,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        // The calendar widget
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: onDaySelected,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
      ],
    );
  }
}
