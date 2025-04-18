import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key});

  @override
  WeekCalendarState createState() => WeekCalendarState();
}

class WeekCalendarState extends State<WeekCalendar> {
  DateTime _selectedDate = DateTime.now();
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = _today.subtract(Duration(days: _today.weekday - 1 - index));
        final isToday = day.day == _today.day &&
            day.month == _today.month &&
            day.year == _today.year;
        final isSelected = day.day == _selectedDate.day &&
            day.month == _selectedDate.month &&
            day.year == _selectedDate.year;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = day;
            });
          },
          child: Container(
            width: (size.width - 32 )/ 7 , 
            height: (size.width - 32) / 7 ,
            decoration: BoxDecoration(
              color: isToday
                  ? (isSelected ? Colors.red.shade100 : Colors.green.shade100)
                  : Colors.transparent,
              border:
                  isSelected ? Border.all(color: Colors.grey.shade300, width: 2) : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.E().format(day), // Display weekday (e.g., Mon)
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 2),
                Text(
                  day.day.toString(), // Display day of the month
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void main() => runApp(MaterialApp(
      home: WeekCalendar(),
    ));
