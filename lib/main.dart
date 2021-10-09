import "package:flutter/material.dart";
import "package:food_busters/views/login.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Busters",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF4E3D8),
      ),
      home: const LoginPage(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("th"),
      ],
    );
  }
}
