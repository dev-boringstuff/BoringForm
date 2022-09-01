import 'package:boring_form_builder/src/boring_controller.dart';

class BoringSupportController<T> {
  BoringSupportController(this.controller);
  BoringController<T> controller;
}

class BoringSupportValue<T> {
  BoringSupportValue({this.value});
  T? value;
}
