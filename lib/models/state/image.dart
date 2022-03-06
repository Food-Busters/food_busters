// 📦 Package imports:
import "package:camera/camera.dart";

abstract class ImageState {
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
}
