import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_field_with_validation.dart';
import 'package:flutter/material.dart';

class BoringDoubleField extends StatefulWidget
    implements BoringFieldWithValidation<double> {
  const BoringDoubleField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.validator,
    this.onChanged,
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
  final double? initialValue;
  @override
  final String? Function(double?)? validator;
  @override
  final BoringFieldController<double>? controller;
  @override
  final void Function(double?)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  @override
  BoringDoubleField copyWith() {
    return BoringDoubleField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      validator: validator,
      controller: controller ?? BoringFieldController<double>(),
      onChanged: onChanged,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );
  }

  @override
  State<BoringDoubleField> createState() => _BoringDoubleFieldState();
}

class _BoringDoubleFieldState extends State<BoringDoubleField>
    implements BoringFieldStateWithValidation<String> {
  final textController = TextEditingController();
  String? savedError;
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue;
    updateValid();
    textController.text = widget.controller?.value != null
        ? widget.controller!.value.toString()
        : '';

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldReset ?? false) &&
          !(widget.controller?.isResetting ?? false)) {
        reset();
      }
    });

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldGetValid ?? false) &&
          !(widget.controller?.isGettingValid ?? false)) {
        updateValid();
      }
    });

    widget.controller?.addListener(() {
      if ((widget.controller?.shouldValidate ?? false) &&
          !(widget.controller?.isValidating ?? false)) {
        validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.number,
      onChanged: (v) {
        setState(() {
          errorText = null;
        });
        widget.controller?.value = double.tryParse(v);
        updateValid();
        widget.onChanged?.call(double.tryParse(v));
      },
      decoration: InputDecoration(
        label: Text(widget.label),
        helperText: widget.helperText,
        errorText: errorText,
      ),
    );
  }

  @override
  void reset() {
    setState(() {
      errorText = null;
    });
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    widget.controller?.value = widget.initialValue;
    updateValid();
    textController.text = widget.controller?.value != null
        ? widget.controller!.value.toString()
        : '';
    widget.controller?.isResetting = false;
  }

  @override
  void updateValid() {
    savedError = widget.validator?.call(widget.controller?.value);
    widget.controller?.valid = savedError == null;
  }

  @override
  void validate() {
    widget.controller?.shouldValidate = false;
    widget.controller?.isValidating = true;
    setState(() {
      errorText = savedError;
    });
    widget.controller?.isValidating = false;
  }
}
