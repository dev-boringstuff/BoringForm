import 'package:flutter/material.dart';

class BoringFieldController<T> extends ChangeNotifier {
  BoringFieldController() : super();
  T? Function() getValue = () => null;
  void Function() reset = () {};
  void addValidationCallback(void Function() listener) {
    addListener(listener);
  }

  void validate() {
    notifyListeners();
  }

  bool Function() isValid = () => false;
}
