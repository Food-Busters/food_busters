import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/data/food_data.dart";
import "package:food_busters/models/health_record.dart";
import "package:food_busters/styles/styles.dart";
import "package:pie_chart/pie_chart.dart";
import "package:table_calendar/table_calendar.dart";

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(text.my_record),
            const Text(" PREMIUM", style: TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 100.0,
              horizontal: 24.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: calendar(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: guide(text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            firstDay: DateTime.utc(2021, 10, 1),
            lastDay: DateTime.utc(2030, 12, 31),
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
                  return Column(
                    children: [
                      PieChart(
                        dataMap: data.nutrition,
                        chartType: ChartType.ring,
                      ),
                      Text(
                        text.recorded_menu,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          recordedMenu(text.breakfast, data.breakfast),
                          recordedMenu(text.lunch, data.lunch),
                          recordedMenu(text.dinner, data.dinner),
                        ],
                      ),
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
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/foods/vegetable.png",
                            height: 70,
                          ),
                          Text(text.guide_vegetable_header, style: bold),
                        ],
                      ),
                      Text(text.guide_vegetable_content),
                    ],
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );

  Widget recordedMenu(String meal, String data) => Text(
        "$meal: $data",
        textAlign: TextAlign.left,
      );
}
