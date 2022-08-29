import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/widgets.dart';

abstract class BoringFieldState<T extends BoringField> extends State<T> {
  @override
  void initState() {
    widget.boringFieldController.addValidationCallback(validate);
    widget.boringFieldController.addResetCallback(reset);
    super.initState();
  }

  void validate();
  void reset();
}
