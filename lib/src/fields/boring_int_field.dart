import 'package:boring_form_builder/src/boring_field.dart';
import 'package:boring_form_builder/src/boring_field_controller.dart';
import 'package:boring_form_builder/src/boring_field_with_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoringIntField extends StatefulWidget
    implements BoringFieldWithValidation<int> {
  const BoringIntField(
      {Key? key,
      required this.jsonKey,
      required this.label,
      this.helperText,
      this.initialValue,
      this.controller,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.validator})
      : super(key: key);

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final int? initialValue;
  @override
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  @override
  final BoringFieldController<int>? controller;

  @override
  BoringIntField copyWithController() {
    return BoringIntField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      validator: validator,
      controller: controller ?? BoringFieldController<int>(),
    );
  }

  @override
  State<BoringIntField> createState() => _BoringIntFieldState();
}

class _BoringIntFieldState extends State<BoringIntField>
    implements BoringFieldState<String> {
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
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      validator: widget.validator,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (v) {
        setState(() {
          errorText = null;
        });
        widget.controller?.value = int.tryParse(v);
        updateValid();
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
    savedError = widget.validator?.call(widget.controller?.value.toString());
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
