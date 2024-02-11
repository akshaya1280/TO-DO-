
class Event {
  String title;
  bool done;
  Event(this.title, this.done);
}

Map<DateTime, List<Event>> events = {
  DateTime.utc(2023, 6, 12): [
    Event("to do list 만들기", false),
    Event("선형대수학 공부하기", false),
  ],
};

List<Event> getEventsForDay(DateTime day) {
  return events[day] ?? [];
}
