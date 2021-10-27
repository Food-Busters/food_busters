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

  // * Points Part
  // ! Subjected to be change to server-based rather than local, ephemeral
  int _points = 18;

  int get points => _points;

  void addPoints(int points) {
    _points += points;
  }

  bool usePoints(int points) {
    if (_points < points) return false;
    _points -= points;
    return true;
  }
}
