// Package imports:
import "package:camera/camera.dart";

class AppState {
  // * Image Part
  XFile? _imageBefore;
  XFile? _imageAfter;

  XFile? get imageBefore => _imageBefore;
  bool get imageBeforeAvailable => _imageBefore != null;
  XFile? get imageAfter => _imageAfter;
  bool get imageAfterAvailable => _imageAfter != null;
  bool get imageReady => imageBeforeAvailable && imageAfterAvailable;

  void setImageBefore(XFile image) {
    _imageBefore = image;
  }

  void deleteImageBefore() {
    _imageBefore = null;
  }

  void setImageAfter(XFile image) {
    _imageAfter = image;
  }

  void resetAllImages() {
    _imageBefore = null;
    _imageAfter = null;
  }

  // * Points Part
  // ! Subjected to be change to server-based rather than local
  // ! for prototype demonstration only
  int _points = 398;

  int get points => _points;

  void addPoints(int points) {
    _points += points;
  }

  bool usePoints(int points) {
    if (_points < points) return false;
    _points -= points;
    return true;
  }

  bool _premium = false;

  bool get isPremiumUser => _premium;

  void assignPremium() {
    _premium = true;
  }

  // * God Mode
  Food menu = Food.chicken;
  int get menuIndex => menu == Food.chicken ? 0 : 1;
  int percent = 50;
}

enum Food {
  chicken,
  omelet,
}
