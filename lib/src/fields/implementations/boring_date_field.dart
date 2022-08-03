import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:boring_form_builder/src/fields/boring_field_with_validation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoringDateField extends StatefulWidget
    implements BoringFieldWithValidation<DateTime> {
  const BoringDateField({
    Key? key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.validator,
    this.dateFormat = 'MM/dd/yyyy',
    this.locale = const Locale('en'),
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
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
  final DateTime? initialValue;
  @override
  final String? Function(DateTime?)? validator;
  @override
  final BoringFieldController<DateTime>? controller;
  @override
  final void Function(DateTime?)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;
  final String dateFormat;
  final Locale locale;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  BoringDateField copyWith() {
    return BoringDateField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      validator: validator,
      controller: controller ?? BoringFieldController<DateTime>(),
      onChanged: onChanged,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      dateFormat: dateFormat,
      locale: locale,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  @override
  State<BoringDateField> createState() => _BoringDateFieldState();
}

class _BoringDateFieldState extends State<BoringDateField>
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
        ? DateFormat(widget.dateFormat).format(widget.controller!.value!)
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
    return TextField(
      mouseCursor: SystemMouseCursors.click,
      controller: textController,
      readOnly: true,
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today),
        label: Text(widget.label),
        helperText: widget.helperText,
        errorText: errorText,
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          fieldHintText: widget.dateFormat,
          locale: widget.locale,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (pickedDate != null) {
          String formattedDate =
              DateFormat(widget.dateFormat).format(pickedDate);
          setState(() {
            errorText = null;
          });
          widget.controller?.value = pickedDate;
          updateValid();
          textController.text = formattedDate;
          widget.onChanged?.call(pickedDate);
        }
      },
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
        ? DateFormat(widget.dateFormat).format(widget.controller!.value!)
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
