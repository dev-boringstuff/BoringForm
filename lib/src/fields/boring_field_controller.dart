import 'package:flutter/material.dart';

class BoringFieldController<T> {
  T? Function() getValue = () => null;
  bool Function() isValid = () => true;
  void Function(T value) setValue = (value) {};

  void Function()? _validateFunction;
  void Function()? _resetFunction;
  void addValidationCallback(void Function() function) {
    _validateFunction = function;
  }

  void addResetCallback(void Function() function) {
    _resetFunction = function;
  }

  void validate() {
    _validateFunction?.call();
  }

  void reset() {
    _resetFunction?.call();
  }
}
