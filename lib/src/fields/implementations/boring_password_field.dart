import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_field_with_validation.dart';
import 'package:flutter/material.dart';

class BoringPasswordField extends StatefulWidget
    implements BoringFieldWithValidation<String> {
  const BoringPasswordField({
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
  final String? initialValue;
  @override
  final String? Function(String?)? validator;
  @override
  final BoringFieldController<String>? controller;
  @override
  final void Function(String)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  @override
  BoringPasswordField copyWith({Function()? onChangedAux}) {
    return BoringPasswordField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      validator: validator,
      controller: controller ?? BoringFieldController<String>(),
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
  State<BoringPasswordField> createState() => _BoringPasswordFieldState();
}

class _BoringPasswordFieldState extends State<BoringPasswordField>
    implements BoringFieldStateWithValidation<String> {
  final textController = TextEditingController();
  String? savedError;
  String? errorText;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    widget.controller?.setValue(widget.initialValue);
    updateValid();
    textController.text = widget.controller?.value ?? '';

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
    return Stack(
      children: [
        TextField(
          controller: textController,
          obscureText: obscureText,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (v) {
            setState(() {
              errorText = null;
            });
            widget.controller?.setValue(v);
            updateValid();
            widget.onChanged?.call(v);
          },
          decoration: InputDecoration(
            label: Text(widget.label),
            helperText: widget.helperText,
            errorText: errorText,
            suffixIcon: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Center(
                  widthFactor: 0,
                  child: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
          ),
        ),
      ],
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
    textController.text = widget.controller?.value ?? '';
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

  @override
  void setValue() {
    // TODO: implement setValue
  }
}
