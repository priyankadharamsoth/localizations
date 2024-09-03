import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/app_loc_extention.dart';

class CalendarDatePickerWidget extends StatefulWidget {
  const CalendarDatePickerWidget({super.key});

  @override
  State<CalendarDatePickerWidget> createState() =>
      _CalendarDatePickerWidgetState();
}

class _CalendarDatePickerWidgetState extends State<CalendarDatePickerWidget> {
  late final ValueNotifier<DateTime?> selectedDate;

  @override
  void initState() {
    selectedDate = ValueNotifier<DateTime?>(null);
    super.initState();
  }

  @override
  void dispose() {
    selectedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLoc;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                selectedDate.value = await showDatePicker(
                      context: context,
                      currentDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      initialDatePickerMode: DatePickerMode.day,
                    ) ??
                    DateTime.now();
              },
              child: Text(l10n.calendarDatePickerButton),
            ),
            const Spacer(),
            ValueListenableBuilder<DateTime?>(
              valueListenable: selectedDate,
              builder: (_, selectedDate, __) {
                return Builder(
                  builder: (context) {
                    if (selectedDate != null) {
                      final locale = Localizations.localeOf(context);
                      return Text(
                        DateFormat.yMMMEd(locale.languageCode)
                            .format(selectedDate),
                        style: const TextStyle(fontSize: 14),
                      );
                    }
                    return Text(
                      l10n.calendarDatePickerNoSelected,
                      style: const TextStyle(fontSize: 14),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
