import 'package:flutter/material.dart';

class BoringFormController extends ChangeNotifier {
  Map<String, dynamic>? receivedValue;
  bool receivedValid = false;
  bool isResetting = false;
  bool shouldReset = false;
  bool isGettingValue = false;
  bool shouldGetValue = false;
  bool isGettingValid = false;
  bool shouldGetValid = false;
  bool isValidating = false;
  bool shouldValidate = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }

  Map<String, dynamic>? get value {
    shouldGetValue = true;
    notifyListeners();

    return receivedValue;
  }

  bool get valid {
    shouldGetValid = true;
    notifyListeners();

    return receivedValid;
  }

  void validate() {
    shouldValidate = true;
    notifyListeners();
  }
}
