import 'package:flutter/material.dart';

class BoringFieldController<T> extends ChangeNotifier {
  T? value;
  bool isResetting = false;
  bool shouldReset = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }
}
