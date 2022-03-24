import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AntiCalendar')),
      body: Builder(builder: (context) {
        return const _Calendar();
      }),
    );
  }
}

class _Calendar extends StatefulWidget {
  const _Calendar({Key? key}) : super(key: key);

  @override
  State<_Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> {
  int day = 1;
  int weekday = 1;

  Widget weekdaySelector(BuildContext context) {
    return DropdownButton<int>(
      value: weekday,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (int? weekday) {
        setState(() {
          this.weekday = weekday ?? 1;
        });
      },
      items: weekdays.entries
          .map(
            (e) => DropdownMenuItem<int>(
              value: e.key,
              child: Text(e.value),
            ),
          )
          .toList(),
    );
  }

  Widget daySelector(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Slider(
          value: day.toDouble(),
          min: 1,
          max: 31,
          divisions: 31,
          onChanged: (double newDay) {
            setState(() {
              day = newDay.round();
            });
          },
        ),
      ),
      Text(day.toString())
    ]);
  }

  Widget yearBuilder(BuildContext context, int year) {
    if (year == 0) {
      return ListTile(
        leading: Text('Year', style: Theme.of(context).textTheme.headline6),
        title: Text('Months where day $day is ${weekdays[weekday]}',
            style: Theme.of(context).textTheme.headline6),
      );
    }

    var print = [];
    for (int i = 0; i < 12; i++) {
      final date = DateTime(year, i + 1, day);
      if (date.month == i + 1 && date.weekday == weekday) {
        print.add(months[i]);
      }
    }

    if (print.isEmpty) {
      return const SizedBox();
    }

    return ListTile(
      leading: Text(year.toString()),
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: print.map((e) => Chip(label: Text(e))).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        weekdaySelector(context),
        Expanded(child: daySelector(context))
      ]),
      Expanded(
        child: ListView.builder(itemBuilder: yearBuilder),
      ),
    ]);
  }
}

const weekdays = {
  DateTime.monday: 'Monday',
  DateTime.tuesday: 'Tuesday',
  DateTime.wednesday: 'Wednesday',
  DateTime.thursday: 'Thursday',
  DateTime.friday: 'Friday',
  DateTime.saturday: 'Saturday',
  DateTime.sunday: 'Sunday',
};

const months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Avg',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
