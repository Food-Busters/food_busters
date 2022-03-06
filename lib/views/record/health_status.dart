// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:niku/namespace.dart" as n;
import "package:pie_chart/pie_chart.dart";
import "package:table_calendar/table_calendar.dart";

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/data/food_data.dart";
import "package:food_busters/models/health_record.dart";
import "package:food_busters/styles/styles.dart";

class HealthStatusPage extends StatefulWidget {
  const HealthStatusPage({Key? key}) : super(key: key);

  @override
  _HealthStatusPageState createState() => _HealthStatusPageState();
}

class _HealthStatusPageState extends State<HealthStatusPage> {
  late DateTime selected;
  late DateTime focused;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selected = focused = DateTime.utc(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: n.Row([
          Text(text.my_record),
          n.Text(" PREMIUM")
            ..fontSize = 14
            ..freezed,
        ])
          ..mainStart
          ..crossBaseline
          ..alphabetic,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.png"),
        bgImage("clouds/top_orange.png"),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 100.0,
            horizontal: 24.0,
          ),
          child: SingleChildScrollView(
            child: n.Column([
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: calendar(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: guide(text),
              ),
            ])
              ..mainCenter,
          ),
        ),
      ]),
    );
  }

  Widget calendar() => Container(
        height: 305,
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TableCalendar(
            focusedDay: focused,
            firstDay: getToday().subtract(const Duration(days: mockDays)),
            lastDay: getToday(),
            availableCalendarFormats: const {CalendarFormat.month: "Month"},
            daysOfWeekVisible: false,
            rowHeight: 40,
            selectedDayPredicate: (day) => isSameDay(day, selected),
            onDaySelected: (newSelected, newFocused) {
              if (isSameDay(focused, newFocused)) {
                return;
              }

              setState(() {
                selected = newSelected;
                focused = newFocused;
              });
            },
          ),
        ),
      );

  Widget guide(AppLocalizations text) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<HealthRecord?>(
            future: getHealthStat(focused),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;
                if (data == null) {
                  return Text(text.no_data_this_day);
                } else {
                  return n.Column([
                    PieChart(
                      dataMap: data.nutrition,
                      chartType: ChartType.ring,
                    ),
                    n.Text(text.recorded_menu)
                      ..w500
                      ..freezed,
                    n.Column([
                      recordedMenu(text.breakfast, data.breakfast),
                      recordedMenu(text.lunch, data.lunch),
                      recordedMenu(text.dinner, data.dinner),
                    ])
                      ..crossStart,
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: lightOrange,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            text.easy_guide,
                            style: bold,
                          ),
                        ),
                      ),
                    ),
                    n.Row([
                      Image.asset(
                        "assets/images/foods/vegetable.png",
                        height: 70,
                      ),
                      Flexible(
                        child: Text(text.guide_vegetable_header, style: bold),
                      ),
                    ])
                      ..crossCenter,
                    Text(text.guide_vegetable_content),
                  ]);
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );

  Widget recordedMenu(String meal, String data) {
    return n.Text("$meal: $data")..left;
  }
}
