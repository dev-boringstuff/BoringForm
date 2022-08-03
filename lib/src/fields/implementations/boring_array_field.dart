import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_controller.dart';
import 'package:flutter/material.dart';

class BoringArrayField extends StatefulWidget
    implements BoringField<Map<String, dynamic>> {
  BoringArrayField({
    super.key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.onChanged,
    required List<BoringField> fields,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  })  : fields = fields.map((field) {
          var newField = field.copyWith();
          return newField;
        }).toList(),
        assert(onChanged == null, "Do not use onChanged on array field");

  @override
  final String jsonKey;
  @override
  final String label;
  @override
  final String? helperText;
  @override
  final Map<String, dynamic>? initialValue;
  @override
  final BoringFieldController<Map<String, dynamic>>? controller;
  @override
  final void Function(Map<String, dynamic>?)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;
  final List<BoringField> fields;

  @override
  BoringArrayField copyWith() {
    return BoringArrayField(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller: controller ?? BoringFieldController<Map<String, dynamic>>(),
      onChanged: onChanged,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      fields: fields,
    );
  }

  @override
  State<BoringArrayField> createState() => _BoringTextFieldState();
}

class _BoringTextFieldState extends State<BoringArrayField>
    implements BoringFieldStateWithValidation<String> {
  double fieldWidth = double.infinity;

  @override
  void initState() {
    super.initState();

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
    const fieldMargin = 6.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox = context.findRenderObject() as RenderBox;
          setState(() {
            fieldWidth = renderBox.size.width;
          });
        });

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.headline4,
              ),
              widget.helperText != null
                  ? Text(
                      widget.helperText!,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : const SizedBox.shrink(),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    children: List.generate(
                      widget.fields.length,
                      (index) => Container(
                        width: (fieldWidth /
                                12 *
                                (constraints.maxWidth >= 1240
                                    ? widget.fields[index].lg
                                    : constraints.maxWidth >= 905
                                        ? widget.fields[index].md
                                        : constraints.maxWidth >= 600
                                            ? widget.fields[index].sm
                                            : widget.fields[index].xs) -
                            fieldMargin * 2),
                        margin:
                            const EdgeInsets.symmetric(horizontal: fieldMargin),
                        child: widget.fields[index],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void reset() {
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    var value = <String, dynamic>{};
    for (var field in widget.fields) {
      field.controller?.reset();
      value[field.jsonKey] = field.controller?.value;
    }
    widget.controller?.value = value;
    widget.controller?.isResetting = false;
  }

  @override
  void updateValid() {
    var valid = true;
    for (var field in widget.fields) {
      field.controller?.getValid();
      valid &= field.controller?.valid ?? false;
    }
    widget.controller?.valid = valid;
  }

  @override
  void validate() {
    widget.controller?.shouldValidate = false;
    widget.controller?.isValidating = true;
    for (var field in widget.fields) {
      field.controller?.validate();
    }
    widget.controller?.isValidating = false;
  }
}
