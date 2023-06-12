import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_list/data.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              TableCalendar(
                locale: 'ko_KR',
                firstDay: DateTime.utc(2023, 01, 01),
                lastDay: DateTime.utc(2023, 12, 31),
                focusedDay: focusedDay,

                // header style
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(date),
                  formatButtonVisible: false,
                  titleTextStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                  leftChevronIcon: const Icon(
                    Icons.arrow_left,
                    size: 30.0,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.arrow_right,
                    size: 30.0,
                  ),
                ),

                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 날짜가 선택되면 selectedDay와 focusDay를 갱신
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // true를 반환하는 날짜의 모양을 변환
                  return isSameDay(selectedDay, day);
                },
                eventLoader: getEventsForDay,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getEventsForDay(selectedDay).length + 1,
                  itemBuilder: (context, index) {
                    if (index != getEventsForDay(selectedDay).length) {
                      return ListTile(
                        title: Text(getEventsForDay(selectedDay)[index].title),
                        subtitle: Text(getEventsForDay(selectedDay)[index].done ? "done" : "not yet"),
                      );
                    } else {
                      return const ListTile(
                        title: Text("할 일 추가하기"),
                        subtitle: Text("할 일 추가"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
