import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:flutter/material.dart';

class BoringCheckbox extends StatefulWidget implements BoringField<bool> {
  const BoringCheckbox({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  }) : super(key: key);

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final bool? initialValue;
  @override
  final BoringFieldController<bool>? controller;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  @override
  BoringCheckbox copyWithController() {
    return BoringCheckbox(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller: controller ?? BoringFieldController<bool>(),
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );
  }

  @override
  State<BoringCheckbox> createState() => _BoringCheckboxState();
}

class _BoringCheckboxState extends State<BoringCheckbox>
    implements BoringFieldState {
  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue ?? false;

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldReset ?? false) &&
          !(widget.controller?.isResetting ?? false)) {
        reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: widget.controller?.value ?? false,
      title: Text(widget.label),
      subtitle: widget.helperText != null ? Text(widget.helperText!) : null,
      onChanged: (newValue) {
        setState(() {
          widget.controller?.value = newValue;
        });
      },
    );
  }

  @override
  void reset() {
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    setState(() {
      widget.controller?.value = widget.initialValue;
    });
    widget.controller?.isResetting = false;
  }
}
