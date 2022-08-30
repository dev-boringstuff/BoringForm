import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/widgets.dart';

abstract class BoringFieldState<T extends BoringField> extends State<T> {
  @override
  void initState() {
    widget.controller.addValidationCallback(validate);
    widget.controller.addResetCallback(reset);
    super.initState();
  }

  void validate();
  void reset();
}
