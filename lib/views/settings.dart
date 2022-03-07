// 🎯 Dart imports:
import "dart:math";

// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/hooks.dart";
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
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
        backgroundColor: const Color(0xFF42AE93),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(t.language),
            trailing: DropdownButton(
              value: t.current_language,
              items: [t.english, t.thai]
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == t.current_language) return;
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
            title: Text(t.notification),
            activeColor: green,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(t.logout),
            onTap: () {
              logOut();
            },
          ),
          ListTile(
            leading: const Icon(Icons.restart_alt_outlined),
            title: const Text("Reset App Data"),
            onTap: () async {
              appState.reset();
              logOut();
            },
          ),
          const ListTile(
            title: Text(
              "GOD MODE",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            title: n.Text(
              "This is placeholder settings, controls the output of "
              "unimplemented Smart Food Scanner Features.",
            )
              ..center
              ..freezed,
          ),
          ListTile(
            title: n.Text("Percent: ${appState.percent}")..center,
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

  void logOut() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
