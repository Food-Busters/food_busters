// 📦 Package imports:
import "package:camera/camera.dart";
import "package:hive/hive.dart";

part "app_state.g.dart";

@HiveType(typeId: 1)
class AppState extends HiveObject {
  @HiveField(0)
  String? _username;
  String? get username => _username;
  set username(String? newUsername) {
    _username = newUsername;
    save();
  }

  @HiveField(1, defaultValue: true)
  bool _notification = true;
  bool get notification => _notification;
  set notification(bool newNotification) {
    _notification = newNotification;
    save();
  }

  @HiveField(2)
  String? _language;
  String? get language => _language;
  set language(String? lang) {
    _language = lang;
    save();
  }

  XFile? _imageBefore;
  XFile? get imageBefore => _imageBefore;
  set imageBefore(XFile? newImage) {
    imageBefore = newImage;
  }

  XFile? _imageAfter;
  XFile? get imageAfter => _imageAfter;
  set imageAfter(XFile? newImage) {
    imageAfter = newImage;
  }

  @HiveField(3, defaultValue: 398)
  int _points = 398;
  int get points => _points;
  set points(int newPoints) {
    _points = newPoints;
    save();
  }

  @HiveField(4, defaultValue: false)
  bool _premium = false;
  bool get isPremiumUser => _premium;
  // no setter

  @HiveField(5, defaultValue: 50)
  int _godModePercent = 50;
  int get godModePercent => _godModePercent;
  set godModePercent(int newGodModePercent) {
    _godModePercent = newGodModePercent;
    save();
  }

  // * Most of getters and setters is automatically filled by GitHub Copilot✨✨

  bool get imageBeforeAvailable => imageBefore != null;
  bool get imageAfterAvailable => imageAfter != null;
  bool get imageReady => imageBeforeAvailable && imageAfterAvailable;

  void resetImages() {
    _imageBefore = null;
    _imageAfter = null;
  }

  void addPoints(int points) {
    this.points += points;
  }

  bool usePoints(int points) {
    if (this.points < points) return false;
    this.points -= points;
    return true;
  }

  void assignPremium() {
    _premium = true;
    save();
  }
}
