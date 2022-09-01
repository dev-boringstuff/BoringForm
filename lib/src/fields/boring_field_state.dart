import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/widgets.dart';

abstract class BoringFieldState<T extends BoringField<N>, N> extends State<T> {
  @override
  void initState() {
    widget.controller.addValidationCallback(validate);
    widget.controller.addResetCallback(reset);
    widget.controller.addSetValueCallback(setValue);
    super.initState();
  }

  void validate();
  void reset();
  void setValue(N? newValue);
}
