import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:food_busters/models/app_state.dart";
import "package:food_busters/views/login.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

// * BEGIN OF APP PROPS
const appBranch = "PROTOTYPE";
// * END OF APP PROPS

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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
