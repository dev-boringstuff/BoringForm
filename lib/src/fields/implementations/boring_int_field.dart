import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_field_with_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoringIntField extends StatefulWidget
    implements BoringFieldWithValidation<int> {
  const BoringIntField({
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
  final int? initialValue;
  @override
  final String? Function(int?)? validator;
  @override
  final BoringFieldController<int>? controller;
  @override
  final void Function(int?)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  @override
  BoringIntField copyWith({void Function()? onChangedAux}) {
    return BoringIntField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      validator: validator,
      controller: controller ?? BoringFieldController<int>(),
      onChanged: (value) {
        onChangedAux?.call();
        onChanged?.call(value);
      },
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );
  }

  @override
  State<BoringIntField> createState() => _BoringIntFieldState();
}

class _BoringIntFieldState extends State<BoringIntField>
    implements BoringFieldStateWithValidation<String> {
  final textController = TextEditingController();
  String? savedError;
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.controller?.setValue(widget.initialValue);
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
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (v) {
        setState(() {
          errorText = null;
        });
        widget.controller?.setValue(int.tryParse(v));
        updateValid();
        widget.onChanged?.call(int.tryParse(v));
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
    widget.controller?.setValue(widget.initialValue);
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
