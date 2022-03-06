// 🐦 Flutter imports:
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// 📦 Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_localizations/flutter_localizations.dart";

// 🌎 Project imports:
import "package:food_busters/models/state/app_state.dart";
import 'package:food_busters/styles/styles.dart';
import "package:food_busters/views/login.dart";

void main() => _main();

Future<void> _main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  // https://stackoverflow.com/questions/65307961/button-to-change-the-language-flutter
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale =
      // https://stackoverflow.com/questions/50923906/how-to-get-timezone-language-and-county-id-in-flutter-by-the-location-of-device
      WidgetsBinding.instance?.window.locales[0] ?? const Locale("en", "US");
  Locale get locale => _locale;

  late String _localeStr;
  String get localeStrSimp => _localeStr.contains("th") ? "th" : "en";

  void setLocale(String value) {
    setState(() {
      _localeStr = value;
      _locale = Locale(value);
    });
  }

  final state = AppState();

  @override
  void initState() {
    super.initState();
    _localeStr = _locale.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Busters",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(color: lightOrange),
        scaffoldBackgroundColor: const Color(0xFFF4E3D8),
        fontFamily: "Kanit",
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
      locale: _locale,
    );
  }
}
