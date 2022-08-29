import 'package:flutter/material.dart';

class BoringFormControllerState {
  Map<String, dynamic>? receivedValue;
  bool receivedValid;
  bool isResetting;
  bool shouldReset;
  bool isGettingValue;
  bool shouldGetValue;
  bool isGettingValid;
  bool shouldGetValid;
  bool isValidating;
  bool shouldValidate;

  BoringFormControllerState({
    this.receivedValue,
    this.receivedValid = false,
    this.isResetting = false,
    this.shouldReset = false,
    this.isGettingValue = false,
    this.shouldGetValue = false,
    this.isGettingValid = false,
    this.shouldGetValid = false,
    this.isValidating = false,
    this.shouldValidate = false,
  });
}

class BoringFormController extends ChangeNotifier {
  BoringFormControllerState state = BoringFormControllerState();

  void reset() {
    state.shouldReset = true;
    notifyListeners();
  }

  Map<String, dynamic>? get value {
    state.shouldGetValue = true;
    notifyListeners();

    return state.receivedValue;
  }

  bool get valid {
    state.shouldGetValid = true;
    notifyListeners();

    return state.receivedValid;
  }

  void validate() {
    state.shouldValidate = true;
    notifyListeners();
  }
}
