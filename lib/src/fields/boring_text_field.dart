import 'package:boring_form_builder/src/boring_field.dart';
import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:flutter/material.dart';

class BoringTextField extends StatefulWidget implements BoringField<String> {
  const BoringTextField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
  }) : super(key: key);

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final String? initialValue;
  @override
  final BoringFieldController<String>? controller;

  @override
  BoringTextField copyWithController() {
    return BoringTextField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller: controller ?? BoringFieldController<String>(),
    );
  }

  @override
  State<BoringTextField> createState() => _BoringTextFieldState();
}

class _BoringTextFieldState extends State<BoringTextField>
    implements BoringFieldState<String> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue;
    textController.text = widget.controller?.value ?? '';

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldReset ?? false) &&
          !(widget.controller?.isResetting ?? false)) {
        reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onChanged: (v) => setState(() {
        widget.controller?.value = v;
      }),
      decoration: InputDecoration(
        label: Text(widget.label),
        helperText: widget.helperText,
      ),
    );
  }

  @override
  void reset() {
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    widget.controller?.value = widget.initialValue;
    textController.text = widget.controller?.value ?? '';
    widget.controller?.isResetting = false;
  }
}
