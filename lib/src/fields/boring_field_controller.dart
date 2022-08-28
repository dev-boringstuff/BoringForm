import 'package:flutter/material.dart';

class BoringFieldController<T> extends ChangeNotifier {
  BoringFieldController() : super();
  T? Function() getValue = () => null;
  void Function() reset = () {};
  bool Function() isValid = () => true;
  void Function(T value) setValue = (value) {};

  void addValidationCallback(void Function() listener) {
    addListener(listener);
  }

  void validate() {
    notifyListeners();
  }
}
