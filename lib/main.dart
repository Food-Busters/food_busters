// 🐦 Flutter imports:
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

// 📦 Package imports:
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:hive_flutter/hive_flutter.dart";

// 🌎 Project imports:
import "package:food_busters/models/app_state.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/home.dart";
import "package:food_busters/views/login.dart";

const boxName = "appData";

void addFontLicense(String fontName) {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString("assets/fonts/$fontName-OFL.txt");
    yield LicenseEntryWithLineBreaks(["google_fonts"], license);
  });
}

Future<void> main() async {
  addFontLicense("Kanit");

  await Future.wait([
    dotenv.load(),
    Hive.initFlutter(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
  Hive.registerAdapter(AppStateAdapter());

  var box = await Hive.openBox<AppState>(boxName);
  if (box.values.isEmpty) {
    box.add(AppState());
  }

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
  @override
  void initState() {
    super.initState();
    resetLocale();
  }

  late Locale _locale;
  Locale get locale => _locale;
  late String _localeStr;

  /// Either "en" or "th"
  String get localeStrSimp => _localeStr.contains("th") ? "th" : "en";

  void setLocale(String value) {
    setState(() {
      state.language = _localeStr = value;
      _locale = Locale(value);
    });
  }

  void resetLocale({bool doSetState = false}) {
    // https://stackoverflow.com/questions/50923906/how-to-get-timezone-language-and-county-id-in-flutter-by-the-location-of-device

    if (state.language != null) {
      _locale = Locale(state.language!);
    } else {
      _locale =
          WidgetsBinding.instance?.window.locales[0] ?? const Locale("en");
    }

    _localeStr = _locale.toString();
    state.language = _localeStr;

    if (doSetState) setState(() {});
  }

  AppState get state => Hive.box<AppState>(boxName).getAt(0)!;

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
      home: state.username == null
          ? const LoginPage()
          : const HomePage(welcomeBack: true),
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
