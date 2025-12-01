import 'package:flutter/material.dart';
import 'package:medication_app_v0/core/components/cards/pill_card.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medication_app_v0/core/extention/context_extention.dart';
import 'package:medication_app_v0/core/components/widgets/drawer.dart';
// easy_localization not used by this file

class CalendarView extends StatefulWidget {
  CalendarView({Key? key}) : super(key: key);
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> with TickerProviderStateMixin {
  Map<DateTime, List<ReminderModel>> _events = {};
  List<ReminderModel> _selectedEvents = [];
  late AnimationController _animationController;
  // TableCalendar v3 uses focusedDay / selectedDay / calendarFormat instead of CalendarController
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
     final DateTime today = DateTime.now();

    _events = {
      today.subtract(Duration(days: 30)): [
        ReminderModel("Teraflu",
         today.subtract(Duration(days: 30, hours: 4)), 25, true),
        ReminderModel("Calpol",
         today.subtract(Duration(days: 30, hours: 1)), 25, false),
      ],
      today.subtract(Duration(days: 27)): [
        ReminderModel("Teraflu",
         today.subtract(Duration(days: 27, hours: 2)), 35, true),
      ],
      today.subtract(Duration(days: 20)): [
        ReminderModel("Teraflu",
         today.subtract(Duration(days: 20, hours: 3)), 40, false),
        ReminderModel("Calpol",
         today.subtract(Duration(days: 20, hours: 2)), 25, false),
        ReminderModel("Jolessa",
         today.subtract(Duration(days: 20, hours: 1)), 25, true),
        ReminderModel(
          "Paromymcin", today.subtract(Duration(days: 20)), 25, true),
      ],
      today.subtract(Duration(days: 16)): [
        ReminderModel("Calpol",
         today.subtract(Duration(days: 16, hours: 4)), 25, false),
        ReminderModel("Jolessa",
         today.subtract(Duration(days: 16, hours: 3)), 25, false),
      ],
      today.subtract(Duration(days: 10)): [
        ReminderModel("Calpol",
         today.subtract(Duration(days: 10, hours: 2)), 25, true),
        ReminderModel("Jolessa",
         today.subtract(Duration(days: 10, hours: 1)), 25, true),
        ReminderModel(
          "Paromymcin", today.subtract(Duration(days: 10)), 25, true),
      ],
      today.subtract(Duration(days: 4)): [
        ReminderModel("Teraflu",
         today.subtract(Duration(days: 4, hours: 4)), 25, true),
        ReminderModel("Calpol",
         today.subtract(Duration(days: 4, hours: 3)), 25, false),
        ReminderModel("Jolessa",
         today.subtract(Duration(days: 4, hours: 1)), 25, true),
      ],
      today.subtract(Duration(days: 2)): [
        ReminderModel("Jolessa",
         today.subtract(Duration(days: 2, hours: 2)), 25, false),
        ReminderModel("Paromymcin",
         today.subtract(Duration(days: 2, hours: 5)), 25, true),
      ],
      today: [
        ReminderModel(
          "Jolessa", today.subtract(Duration(hours: 5)), 25, true),
        ReminderModel(
          "Paromymcin", today.subtract(Duration(hours: 4)), 25, true),
        ReminderModel(
          "Jolessa", today.subtract(Duration(hours: 2)), 25, true),
        ReminderModel("Paromymcin", today, 25, true),
      ],
      today.add(Duration(days: 7)): [
        ReminderModel(
          "Jolessa", today.add(Duration(days: 7, hours: 1)), 25, true),
        ReminderModel("Paromymcin",
          today.add(Duration(days: 7, hours: 2)), 25, true),
        ReminderModel(
          "Teraflu", today.add(Duration(days: 7, hours: 3)), 25, true),
        ReminderModel(
          "Calpol", today.add(Duration(days: 7, hours: 4)), 25, false),
        ReminderModel(
          "Jolessa", today.add(Duration(days: 7, hours: 5)), 25, true),
      ],
    };

     _selectedDay = today;
     _focusedDay = today;
     _selectedEvents = _events[_selectedDay] ?? [];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      // set selected and focused day and update selectedEvents
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents = _events[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)] ?? [];
    });
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      _selectedEvents = _events[DateTime(focusedDay.year, focusedDay.month, focusedDay.day)] ?? [];
    });
    print('CALLBACK: _onPageChanged');
  }

  // TableCalendar v3 doesn't have an onCalendarCreated with the same signature
  // onCalendarCreated removed (v3), not used

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomAppBar(),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(context),
          Divider(
            thickness: 2,
          ),
          Expanded(
              child: Padding(
            padding: context.paddingNormal,
            child: _selectedEvents.isEmpty ? SizedBox() : _buildEventList(),
          )),
        ],
      ),
    );
  }

  // Belki başka bir yerede konulabilir
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }

  // Başka sayfalarda da kullanılacak mı ?
  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              iconSize: context.height * 0.05,
              icon: Icon(Icons.home_outlined),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.medical_services_outlined),
              onPressed: () {},
              iconSize: context.height * 0.05),
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {},
              iconSize: context.height * 0.05),
          IconButton(
              icon: Icon(Icons.bookmark_outline),
              onPressed: () {},
              iconSize: context.height * 0.05)
        ],
      ),
    );
  }

  Widget _buildTableCalendar(BuildContext context) {
    return TableCalendar<ReminderModel>(
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      eventLoader: (day) => _events[DateTime(day.year, day.month, day.day)] ?? [],
      selectedDayPredicate: (day) => _selectedDay != null && isSameDay(_selectedDay!, day),
      rowHeight: context.height * 0.1, //headerin size'ını ayarlamak lazım.
      //locale: context.locale.toString(), tr sürümü yok.
      availableGestures: AvailableGestures.horizontalSwipe,
      startingDayOfWeek: StartingDayOfWeek.monday,
      // calendarFormat is provided by state
      calendarStyle: const CalendarStyle(
        // Visual decorations for selected/today
        selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        todayDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        //outsideStyle:
        //    context.textTheme.headline6.copyWith(color: Colors.red.shade200),
        outsideDaysVisible: false,
        // markersPositionBottom replaced/removed in v3
      ),
      onDaySelected: (selectedDay, focusedDay) => _onDaySelected(selectedDay, focusedDay),
      onPageChanged: (focusedDay) => _onPageChanged(focusedDay),
      headerStyle: HeaderStyle(
        titleTextStyle: context.textTheme.headline6,
        titleCentered: true,
        formatButtonVisible: false,
      ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: context.textTheme.headline6,
          weekendStyle: context.textTheme.headline6.copyWith(color: Colors.black45)),
    );
  }

  Widget _buildEventList() {
    _selectedEvents.sort((a, b) => a.time.compareTo(b.time));
    return ListView.builder(
        itemCount: _selectedEvents.length,
        itemBuilder: (context, index) => PillCard(
              reminder: _selectedEvents[index],
            ));
  }
}
