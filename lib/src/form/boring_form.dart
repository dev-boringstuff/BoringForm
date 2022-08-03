import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringForm extends StatefulWidget {
  BoringForm({
    super.key,
    required this.controller,
    required List<BoringSection> sections,
    this.title,
    this.subtitle,
  }) : sections = sections.map((section) {
          final newSection = section.copyWith();
          return newSection;
        }).toList() {
    var jsonkeysAreValid = true;
    List<String> usedKeys = [];
    for (var section in sections) {
      if (section.jsonKey != null) {
        if (usedKeys.contains(section.jsonKey)) {
          jsonkeysAreValid = false;
          break;
        } else {
          usedKeys.add(section.jsonKey!);
        }
      } else {
        for (var field in section.fields) {
          if (usedKeys.contains(field.jsonKey)) {
            jsonkeysAreValid = false;
            break;
          } else {
            usedKeys.add(field.jsonKey);
          }
        }
      }
    }
    assert(jsonkeysAreValid);
  }

  final BoringFormController controller;
  final String? title;
  final String? subtitle;
  final List<BoringSection> sections;

  @override
  State<BoringForm> createState() => _BoringFormState();
}

class _BoringFormState extends State<BoringForm> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.shouldReset && !widget.controller.isResetting) {
        _reset();
      }
      if (widget.controller.shouldGetValid &&
          !widget.controller.isGettingValid) {
        _getValid();
      }
      if (widget.controller.shouldValidate && !widget.controller.isValidating) {
        _validate();
      }
      if (widget.controller.shouldGetValue &&
          !widget.controller.isGettingValue) {
        _getValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
          ...widget.sections,
        ],
      ),
    );
  }

  void _reset() {
    widget.controller.shouldReset = false;
    widget.controller.isResetting = true;
    for (var section in widget.sections) {
      section.controller?.reset();
    }
    widget.controller.isResetting = false;
  }

  void _getValid() {
    widget.controller.shouldGetValid = false;
    widget.controller.isGettingValue = true;
    bool isValid = true;
    for (var section in widget.sections) {
      section.controller?.updateValid();
      isValid &= section.controller?.valid ?? false;
    }
    widget.controller.receivedValid = isValid;
    widget.controller.isGettingValue = false;
  }

  void _validate() {
    widget.controller.shouldValidate = false;
    widget.controller.isValidating = true;
    for (var section in widget.sections) {
      section.controller?.validate();
    }
    widget.controller.isValidating = false;
  }

  void _getValue() {
    widget.controller.shouldGetValue = false;
    widget.controller.isGettingValue = true;
    final newValue = <String, dynamic>{};
    for (var section in widget.sections) {
      section.controller?.getValue();
      if (section.jsonKey != null) {
        newValue[section.jsonKey!] = section.controller?.value ?? {};
      } else {
        final sectionValue = section.controller?.value ?? {};
        sectionValue.forEach((k, v) => newValue[k] = v);
      }
    }
    widget.controller.receivedValue = newValue;
    widget.controller.isGettingValue = false;
  }
}
