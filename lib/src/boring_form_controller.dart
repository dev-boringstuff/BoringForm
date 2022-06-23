import 'package:flutter/material.dart';

class BoringFormController extends ChangeNotifier {
  bool isResetting = false;
  bool shouldReset = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }
}
