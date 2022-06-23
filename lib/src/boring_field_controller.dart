import 'package:flutter/material.dart';

class BoringFieldController<T> extends ChangeNotifier {
  bool isResetting = false;
  bool shouldReset = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }
}
