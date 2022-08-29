import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringFormNew extends BoringField {
  BoringFormNew({
    super.key,
    required this.sections,
    this.title,
    this.description,
    this.subtitle,
    required super.boringFieldController,
  }) : super(jsonKey: '');

  final List<BoringSection> sections;
  final String? title, subtitle, description;

  @override
  BoringFieldState<BoringFormNew> createState() => _BoringFormState();

  @override
  bool get isValid => sections.every((element) => element.isValid);

  @override
  void onChanged(value) {
    throw UnimplementedError();
  }

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

class _BoringFormState extends BoringFieldState<BoringFormNew> {
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
          ...widget.sections,
        ],
      ),
    );
  }

  @override
  void reset() {
    for (var field in widget.sections) {
      field.boringFieldController.reset();
    }
  }

  @override
  void validate() {
    for (var field in widget.sections) {
      field.boringFieldController.validate();
    }
  }
}
