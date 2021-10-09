import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/main.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(text.settings),
        backgroundColor: const Color(0xFF42AE93),
      ),
      body: ListView(
        children: [
          ListTile(
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
        ],
      ),
    );
  }
}
