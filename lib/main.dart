import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/app_loc_extention.dart';
import 'package:localization/calender_date_picker.dart';
import 'package:localization/custom_appbar.dart';
import 'package:localization/locale_provicer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Builder(
        builder: (context) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: provider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    provider.setLocale(supportedLocale);
                  });
                  return supportedLocale;
                }
              }
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                provider.setLocale(supportedLocales.last);
              });
              return supportedLocales.last;
            },
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appLoc = context.appLoc;
    double amount = 1234567.89;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                appLoc.hello("priya"),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Date Picker",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const CalendarDatePickerWidget(),
              const Text(
                "Number Formatter",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currencyConverter(amount, "en_US", "US Dollar"),
              currencyConverter(amount, "de_DE", "Euro"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget currencyConverter(double amount, String? locale, String formatName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("$formatName:  "),
      Text(NumberFormat.currency(locale: locale).format(amount).toString())
    ],
  );
}
