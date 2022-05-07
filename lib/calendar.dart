import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './translations/locale_keys.g.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        LocaleKeys.anticalendar.tr(),
      )),
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
        leading: Text(LocaleKeys.year.tr(),
            style: Theme.of(context).textTheme.headline6),
        title: Text(
            LocaleKeys.months_where_day_.tr() +
                day.toString() +
                LocaleKeys.iss.tr() +
                (weekdays[weekday] ?? ''),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(children: [
          weekdaySelector(context),
          Expanded(child: daySelector(context))
        ]),
        Expanded(
          child: ListView.builder(itemBuilder: yearBuilder),
        ),
      ]),
    );
  }
}

final weekdays = {
  DateTime.monday: LocaleKeys.monday.tr(),
  DateTime.tuesday: LocaleKeys.tuesday.tr(),
  DateTime.wednesday: LocaleKeys.wednesday.tr(),
  DateTime.thursday: LocaleKeys.thursday.tr(),
  DateTime.friday: LocaleKeys.friday.tr(),
  DateTime.saturday: LocaleKeys.saturday.tr(),
  DateTime.sunday: LocaleKeys.sunday.tr(),
};

final months = [
  LocaleKeys.jan.tr(),
  LocaleKeys.feb.tr(),
  LocaleKeys.mar.tr(),
  LocaleKeys.apr.tr(),
  LocaleKeys.may.tr(),
  LocaleKeys.jun.tr(),
  LocaleKeys.jul.tr(),
  LocaleKeys.aug.tr(),
  LocaleKeys.sep.tr(),
  LocaleKeys.oct.tr(),
  LocaleKeys.nov.tr(),
  LocaleKeys.dec.tr()
];
