import 'package:flutter/material.dart';

class BoringSectionController extends ChangeNotifier {
  bool valid = false;
  Map<String, dynamic> value = {};
  bool isResetting = false;
  bool shouldReset = false;
  bool isValidating = false;
  bool shouldValidate = false;
  bool isUpdatingValid = false;
  bool shouldUpdateValid = false;
  bool isGettingValue = false;
  bool shouldGetValue = false;

  void reset() {
    shouldReset = true;
    notifyListeners();
  }

  void validate() {
    shouldValidate = true;
    notifyListeners();
  }

  void updateValid() {
    shouldUpdateValid = true;
    notifyListeners();
  }

  void getValue() {
    shouldGetValue = true;
    notifyListeners();
  }
}
