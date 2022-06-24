import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringForm extends StatefulWidget {
  const BoringForm({
    Key? key,
    required this.controller,
    required this.sections,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final BoringFormController controller;
  final String? title;
  final String? subtitle;
  final List<BoringSection> sections;

  @override
  State<BoringForm> createState() => _BoringFormState();
}

class _BoringFormState extends State<BoringForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.shouldReset && !widget.controller.isResetting) {
        _reset();
      }

      if (widget.controller.shouldGetValue &&
          !widget.controller.isGettingValue) {
        _getValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
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

  void _getValue() {
    widget.controller.shouldGetValue = false;
    widget.controller.isGettingValue = true;
    Map<String, dynamic>? newValue;
    if (_formKey.currentState?.validate() ?? false) {
      newValue = {};
      for (var section in widget.sections) {
        if (section.jsonKey != null) {
          newValue[section.jsonKey!] = section.getValue();
        } else {
          final sectionValue = section.getValue();
          sectionValue.forEach((k, v) => newValue![k] = v);
        }
      }
    }
    widget.controller.receivedValue = newValue;
    widget.controller.isGettingValue = false;
  }
}
