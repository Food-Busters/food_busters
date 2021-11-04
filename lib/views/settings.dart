import "dart:math";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_toggle_tab/flutter_toggle_tab.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/login.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // * Stateful Stateless State
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final appState = MyApp.of(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(text.settings),
        backgroundColor: const Color(0xFF42AE93),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(text.language),
            trailing: DropdownButton(
              value: text.current_language,
              items: [text.english, text.thai]
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == text.current_language) return;
                setState(() {
                  if (value == "Thai") {
                    MyApp.of(context).setLocale("th");
                  } else if (value == "ภาษาอังกฤษ") {
                    MyApp.of(context).setLocale("en");
                  } else {
                    throw "ERROR: Unknown Language";
                  }
                });
              },
            ),
          ),
          SwitchListTile(
            value: notification,
            onChanged: (newValue) {
              setState(() {
                notification = newValue;
              });
            },
            secondary: const Icon(Icons.notifications),
            title: Text(text.notification),
            activeColor: green,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(text.logout),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
          ),
          const ListTile(
            title: Text(
              "GOD MODE",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          FlutterToggleTab(
            labels: const ["Chicken", "Omelet"],
            selectedLabelIndex: (index) {
              setState(() {
                appState.menu = index == 0 ? "Chicken" : "Omelet";
              });
            },
            selectedIndex: appState.menuIndex,
            selectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            selectedBackgroundColors: const [lightGreen],
          ),
          ListTile(
            title: Text(
              "Percent: ${appState.percent}",
              textAlign: TextAlign.center,
            ),
            leading: ElevatedButton(
              onPressed: () {
                setState(() {
                  appState.percent = max(0, appState.percent - 5);
                });
              },
              child: const Icon(Icons.remove),
              style: ElevatedButton.styleFrom(primary: lightGreen),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  appState.percent = min(100, appState.percent + 5);
                });
              },
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(primary: lightGreen),
            ),
          ),
        ],
      ),
    );
  }
}
