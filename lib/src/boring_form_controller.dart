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

  Map<String, dynamic>? getValue() {
    shouldGetValue = true;
    notifyListeners();

    return receivedValue;
  }
}
