import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_my/utils/colors/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late PageController _pageController;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    String headerText = DateFormat.MMMM().format(_focusedDay);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Calendar(pageController: _pageController, focusedDay: _focusedDay, onPageChanged: _onPageChanged)),
          Text(headerText),
        ],
      ),
    );
  }

  void _onPageChanged(DateTime newFocusedDay) {
    setState(() {
      _focusedDay = newFocusedDay;
    });
  }
}

class Calendar extends StatelessWidget {
  Calendar({
    Key? key,
    required this.pageController,
    required this.focusedDay,
    required this.onPageChanged,
  }) : super(key: key);

  final PageController pageController;
  final DateTime focusedDay;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                    onPageChanged(focusedDay.subtract(const Duration(days: 30)));
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black,
                  ),
                ),
                Text(DateFormat.MMMM().format(focusedDay)),
                IconButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                    onPageChanged(focusedDay.add(const Duration(days: 30)));
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Center(
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focusedDay,
                onPageChanged: (newFocusedDay) => onPageChanged(newFocusedDay),
                headerVisible: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

