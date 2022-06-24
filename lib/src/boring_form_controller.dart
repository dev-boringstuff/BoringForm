import 'package:flutter/material.dart';

class BoringFormController extends ChangeNotifier {
  Map<String, dynamic>? receivedValue;
  bool isResetting = false;
  bool shouldReset = false;
  bool isGettingValue = false;
  bool shouldGetValue = false;

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
    return value != null;
  }
}
