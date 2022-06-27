import 'package:flutter/material.dart';

class BoringFieldController<T> extends ChangeNotifier {
  T? value;
  bool valid = false;
  bool isResetting = false;
  bool shouldReset = false;
  bool isValidating = false;
  bool shouldValidate = false;
  bool isGettingValid = false;
  bool shouldGetValid = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }

  void getValid() {
    shouldGetValid = true;
    notifyListeners();
  }

  void validate() {
    shouldValidate = true;
    notifyListeners();
  }
}
