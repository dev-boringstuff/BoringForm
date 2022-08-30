import 'package:boring_form_builder/src/boring_section.dart';
import 'package:boring_form_builder/src/fields/boring_field.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringForm extends BoringField {
  BoringForm({
    super.key,
    required this.sections,
    super.title,
    this.description,
    this.subtitle,
    required super.controller,
  }) : super(jsonKey: '');

  final List<BoringSection> sections;
  final String? subtitle;
  final String? description;

  @override
  BoringFieldState<BoringForm> createState() => _BoringFormState();

  @override
  bool get isValid => sections.every((element) => element.isValid);

  @override
  set setValue(value) {
    throw UnimplementedError();
  }

  @override
  get value {
    Map<String, dynamic> sectionValue = {};
    for (var element in sections) {
      sectionValue[element.jsonKey] = element.value;
    }
    return sectionValue;
  }
}

class _BoringFormState extends BoringFieldState<BoringForm> {
  double sectionWidth = double.infinity;

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
          widget.description != null
              ? Text(widget.description!)
              : const SizedBox.shrink(),
          ...widget.sections,
        ],
      ),
    );
  }

  @override
  void reset() {
    for (var field in widget.sections) {
      field.controller.reset();
    }
  }

  @override
  void validate() {
    for (var field in widget.sections) {
      field.controller.validate();
    }
  }
}
