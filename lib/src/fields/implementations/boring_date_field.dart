import 'package:boring_form_builder/src/boring_support_value.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoringDateField extends BoringField<DateTime> {
  BoringDateField({
    super.initialValue,
    super.validator,
    required super.controller,
    super.title,
    super.helperText,
    required super.jsonKey,
    super.onChanged,
    this.dateFormat = 'MM/dd/yyyy',
    this.locale = const Locale('en'),
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  final TextEditingController textController = TextEditingController();
  @override
  DateTime get value => supportValue.value;

  @override
  bool get isValid =>
      (validator != null) ? validator?.call(value) == null : true;
  @override
  BoringFieldState<BoringDateField> createState() => _BoringTextFieldState();

  @override
  set setValue(DateTime? value) {
    supportValue.value = value;
  }

  final BoringSupportValue supportValue = BoringSupportValue();
  final String dateFormat;
  final Locale locale;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
}

class _BoringTextFieldState extends BoringFieldState<BoringDateField> {
  final textController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      mouseCursor: SystemMouseCursors.click,
      controller: textController,
      readOnly: true,
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today),
        label: Text(widget.title ?? ''),
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
          widget.setValue = pickedDate;
          textController.text = formattedDate;
          widget.onChanged?.call(pickedDate);
        }
      },
    );
  }

  @override
  void validate() {
    setState(() {
      errorText = widget.validator?.call(widget.value);
    });
  }

  @override
  void reset() {
    widget.setValue = widget.initialValue;
  }
}
