import 'package:flutter/material.dart';

class BoringSectionControllerState {
  bool isResetting;
  bool shouldReset;
  bool isValidating;
  bool shouldValidate;
  bool isUpdatingValid;
  bool shouldUpdateValid;
  bool isGettingValue;
  bool shouldGetValue;

  BoringSectionControllerState({
    this.isResetting = false,
    this.shouldReset = false,
    this.isValidating = false,
    this.shouldValidate = false,
    this.isUpdatingValid = false,
    this.shouldUpdateValid = false,
    this.isGettingValue = false,
    this.shouldGetValue = false,
  });
}

class BoringSectionController extends ChangeNotifier {
  bool valid = false;
  Map<String, dynamic> value = {};
  BoringSectionControllerState state = BoringSectionControllerState();

  void reset() {
    state.shouldReset = true;
    notifyListeners();
  }

  void validate() {
    state.shouldValidate = true;
    notifyListeners();
  }

  void updateValid() {
    state.shouldUpdateValid = true;
    notifyListeners();
  }

  void getValue() {
    state.shouldGetValue = true;
    notifyListeners();
  }
}
