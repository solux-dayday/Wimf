import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(
    MaterialApp(
      home: CalendarPage(),
    ),
  );
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final LinkedHashMap<DateTime, List<Event>> _events = LinkedHashMap(
    equals: isSameDay,
  )..addAll({
    DateTime(2024, 2, 1): [
      Event(date: DateTime(2024, 2, 1), mealType: 'Breakfast', meal: '육회비빔밥'),
      Event(date: DateTime(2024, 2, 1), mealType: 'Lunch', meal: '치킨'),
      Event(date: DateTime(2024, 2, 1), mealType: 'Dinner', meal: ''),
    ],
    DateTime(2024, 2, 2): [
      Event(date: DateTime(2024, 2, 2), mealType: 'Breakfast', meal: '떡볶이'),
      Event(date: DateTime(2024, 2, 2), mealType: 'Lunch', meal: '순대국밥'),
      Event(date: DateTime(2024, 2, 2), mealType: 'Dinner', meal: ''),
    ],
    DateTime(2024, 2, 3): [
      Event(date: DateTime(2024, 2, 3), mealType: 'Breakfast', meal: '계란찜'),
      Event(date: DateTime(2024, 2, 3), mealType: 'Lunch', meal: '된장찌개'),
      Event(date: DateTime(2024, 2, 3), mealType: 'Dinner', meal: '치킨'),
    ],
    DateTime(2024, 2, 4): [
      Event(date: DateTime(2024, 2, 4), mealType: 'Breakfast', meal: ''),
      Event(date: DateTime(2024, 2, 4), mealType: 'Lunch', meal: ''),
      Event(date: DateTime(2024, 2, 4), mealType: 'Dinner', meal: '김치찌개'),
    ],
  });


  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  int _getNonEmptyMealCount(DateTime day) {
    return _getEventsForDay(day).where((event) => event.meal.isNotEmpty).length;
  }

  Widget _buildMealContainer(String mealType, String meal) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$mealType:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Text(
            meal,
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }

  Widget _buildEventContainer(Event event) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          _buildMealContainer(event.mealType, event.meal),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              headerVisible: false,
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.grey),
                markerSize: 10.0,
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                singleMarkerBuilder: (context, date, events) {
                  int nonEmptyMealCount = _getNonEmptyMealCount(date);
                  if (nonEmptyMealCount > 0) {
                    return Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: date == selectedDay ? Colors.white : Colors.black),
                      width: 5.0,
                      height: 5.0,
                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    );
                  } else {
                    return SizedBox.shrink(); // If no non-empty meals, don't show marker
                  }
                },
              ),
              onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDay, day);
              },
              calendarFormat: _calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: '한달',
                CalendarFormat.twoWeeks: '2주',
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _getEventsForDay,
            ),
            SizedBox(height: 16),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: _getEventsForDay(selectedDay).map((event) {
                return _buildEventContainer(event);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final DateTime date;
  final String mealType;
  final String meal;

  Event({required this.date, required this.mealType, required this.meal});
}
