import 'package:boring_form_builder/src/form/boring_form_controller.dart';
import 'package:boring_form_builder/src/sections/boring_section.dart';
import 'package:flutter/material.dart';

class BoringForm extends StatefulWidget {
  BoringForm({
    super.key,
    required this.controller,
    required List<BoringSection> sections,
    this.title,
    this.subtitle,
  }) : // Aggiungo i controller alle section se non sono presenti
        sections = sections.map((section) {
          final newSection = section.copyWith();
          return newSection;
        }).toList() {
    // Verifico che le json key non si ripetano nell'albero della form
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
      if (widget.controller.state.shouldReset &&
          !widget.controller.state.isResetting) {
        _reset();
      }
      if (widget.controller.state.shouldGetValid &&
          !widget.controller.state.isGettingValid) {
        _getValid();
      }
      if (widget.controller.state.shouldValidate &&
          !widget.controller.state.isValidating) {
        _validate();
      }
      if (widget.controller.state.shouldGetValue &&
          !widget.controller.state.isGettingValue) {
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
    widget.controller.state.shouldReset = false;
    widget.controller.state.isResetting = true;
    for (var section in widget.sections) {
      section.controller?.reset();
    }
    widget.controller.state.isResetting = false;
  }

  void _getValid() {
    widget.controller.state.shouldGetValid = false;
    widget.controller.state.isGettingValue = true;
    bool isValid = true;
    for (var section in widget.sections) {
      section.controller?.updateValid();
      isValid &= section.controller?.valid ?? false;
    }
    widget.controller.state.receivedValid = isValid;
    widget.controller.state.isGettingValue = false;
  }

  void _validate() {
    widget.controller.state.shouldValidate = false;
    widget.controller.state.isValidating = true;
    for (var section in widget.sections) {
      section.controller?.validate();
    }
    widget.controller.state.isValidating = false;
  }

  void _getValue() {
    widget.controller.state.shouldGetValue = false;
    widget.controller.state.isGettingValue = true;
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
    widget.controller.state.receivedValue = newValue;
    widget.controller.state.isGettingValue = false;
  }
}
