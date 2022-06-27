import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringForm extends StatefulWidget {
  BoringForm({
    Key? key,
    required this.controller,
    required this.sections,
    this.title,
    this.subtitle,
  }) : super(key: key) {
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
      section.reset();
    }
    widget.controller.isResetting = false;
  }

  void _getValid() {
    widget.controller.shouldGetValid = false;
    widget.controller.isGettingValue = true;
    bool isValid = true;
    for (var section in widget.sections) {
      section.updateValid();
      isValid &= section.getValid();
    }
    widget.controller.receivedValid = isValid;
    widget.controller.isGettingValue = false;
  }

  void _validate() {
    widget.controller.shouldValidate = false;
    widget.controller.isValidating = true;
    for (var section in widget.sections) {
      section.validate();
    }
    widget.controller.isValidating = false;
  }

  void _getValue() {
    widget.controller.shouldGetValue = false;
    widget.controller.isGettingValue = true;
    final newValue = <String, dynamic>{};
    for (var section in widget.sections) {
      if (section.jsonKey != null) {
        newValue[section.jsonKey!] = section.getValue();
      } else {
        final sectionValue = section.getValue();
        sectionValue.forEach((k, v) => newValue[k] = v);
      }
    }
    widget.controller.receivedValue = newValue;
    widget.controller.isGettingValue = false;
  }
}
