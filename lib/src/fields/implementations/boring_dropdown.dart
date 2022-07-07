import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_required.dart';
import 'package:flutter/material.dart';

class BoringDropdown<T> extends StatefulWidget
    implements BoringFieldRequired<T> {
  const BoringDropdown({
    super.key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.required,
    required this.items,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  });

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final T? initialValue;
  @override
  final BoringFieldController<T>? controller;
  @override
  final String? required;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;
  final List<DropdownMenuItem<T>> items;

  @override
  BoringDropdown<T> copyWithController() {
    return BoringDropdown<T>(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller: controller ?? BoringFieldController<T>(),
      required: required,
      items: items,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );
  }

  @override
  State<BoringDropdown<T>> createState() => _BoringDropdownState<T>();
}

class _BoringDropdownState<T> extends State<BoringDropdown<T>>
    implements BoringFieldStateWithValidation<T> {
  bool error = false;

  @override
  void initState() {
    super.initState();

    widget.controller?.value = widget.initialValue;
    updateValid();

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
    return Center(
      child: DropdownButton<T>(
        alignment: Alignment.bottomCenter,
        underline: error
            ? Container(
                height: 2,
                color: Theme.of(context).colorScheme.error,
              )
            : null,
        hint: Text(widget.label),
        value: widget.controller?.value,
        onChanged: (T? newValue) {
          setState(() {
            widget.controller?.value = newValue;
          });
          updateValid();
        },
        items: widget.items,
      ),
    );
  }

  @override
  void reset() {
    setState(() {
      error = false;
    });
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    widget.controller?.value = widget.initialValue;
    updateValid();
    setState(() {
      widget.controller?.value = widget.initialValue;
    });
    widget.controller?.isResetting = false;
  }

  @override
  void updateValid() {
    setState(() {
      error = false;
    });
    widget.controller?.valid =
        widget.required != null ? widget.controller?.value != null : true;
  }

  @override
  void validate() {
    widget.controller?.shouldValidate = false;
    widget.controller?.isValidating = true;
    setState(() {
      error =
          widget.required != null ? widget.controller?.value == null : false;
    });
    widget.controller?.isValidating = false;
  }
}
