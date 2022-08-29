import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/sections/boring_section_controller.dart';
import 'package:flutter/material.dart';

class BoringSectionOLD extends StatefulWidget {
  BoringSectionOLD({
    super.key,
    this.title,
    this.subtitle,
    required List<BoringField> fields,
    this.jsonKey,
    this.controller,
  }) : // Aggiungo i controller ai field se non sono presenti
        fields = fields.map((field) {
          final newField = field.copyWith();
          return newField;
        }).toList();

  final String? title;
  final String? subtitle;
  final String? jsonKey;
  final List<BoringField> fields;
  final BoringSectionController? controller;

  BoringSection copyWith() {
    return BoringSection(
      jsonKey: jsonKey,
      title: title,
      subtitle: subtitle,
      fields: fields,
      controller: controller ?? BoringSectionController(),
    );
  }

  @override
  State<BoringSection> createState() => _BoringSectionState();
}

class _BoringSectionState extends State<BoringSection> {
  double sectionWidth = double.infinity;

  @override
  void initState() {
    super.initState();

    widget.controller?.addListener(() {
      if ((widget.controller?.state.shouldReset ?? false) &&
          !(widget.controller?.state.isResetting ?? false)) {
        _reset();
      }

      if ((widget.controller?.state.shouldValidate ?? false) &&
          !(widget.controller?.state.isValidating ?? false)) {
        _validate();
      }

      if ((widget.controller?.state.shouldUpdateValid ?? false) &&
          !(widget.controller?.state.isUpdatingValid ?? false)) {
        _updateValid();
      }

      if ((widget.controller?.state.shouldGetValue ?? false) &&
          !(widget.controller?.state.isGettingValue ?? false)) {
        _getValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const fieldMargin = 6.0;

    return Builder(
      builder: (context) {
        // Setto la variabile della width basandomi sulla width renderizzata
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox = context.findRenderObject() as RenderBox;
          setState(() {
            sectionWidth = renderBox.size.width;
          });
        });

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != null
                  ? Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  : const SizedBox.shrink(),
              widget.subtitle != null
                  ? Text(
                      widget.subtitle!,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : const SizedBox.shrink(),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calcolo la width dei field
                  return Wrap(
                    children: List.generate(
                      widget.fields.length,
                      (index) => Container(
                        width: (sectionWidth /
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

  void _reset() {
    widget.controller?.state.shouldReset = false;
    widget.controller?.state.isResetting = true;
    for (var field in widget.fields) {
      field.controller?.reset();
    }
    widget.controller?.state.isResetting = false;
  }

  void _updateValid() {
    widget.controller?.state.shouldUpdateValid = false;
    widget.controller?.state.isUpdatingValid = true;
    bool isValid = true;
    for (var field in widget.fields) {
      field.controller?.getValid();
      isValid &= field.controller?.valid ?? false;
    }
    widget.controller?.valid = isValid;
    widget.controller?.state.isUpdatingValid = false;
  }

  void _validate() {
    widget.controller?.state.shouldValidate = false;
    widget.controller?.state.isValidating = true;
    for (var field in widget.fields) {
      field.controller?.validate();
    }
    widget.controller?.state.isValidating = false;
  }

  void _getValue() {
    widget.controller?.state.shouldGetValue = false;
    widget.controller?.state.isGettingValue = true;
    final valuesMap = <String, dynamic>{};
    for (var field in widget.fields) {
      valuesMap[field.jsonKey] = field.controller?.value;
    }
    widget.controller?.value = valuesMap;
    widget.controller?.state.isGettingValue = false;
  }
}
