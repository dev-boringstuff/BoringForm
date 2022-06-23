import 'package:boring_form_builder/src/boring_field.dart';
import 'package:flutter/material.dart';

class BoringSection extends StatelessWidget {
  BoringSection({
    Key? key,
    this.title,
    this.subtitle,
    required List<BoringField> fields,
    this.jsonKey,
  })  : fields = fields.map((field) {
          final newField = field.copyWithController();
          return newField;
        }).toList(),
        super(key: key);

  final String? title;
  final String? subtitle;
  final String? jsonKey;
  final List<BoringField> fields;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.headline4,
              )
            : const SizedBox.shrink(),
        subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.headline6,
              )
            : const SizedBox.shrink(),
        ...fields
      ],
    );
  }

  void reset() {
    for (var field in fields) {
      field.controller?.reset();
    }
  }

  Map<String, dynamic> getValue() {
    final valuesMap = <String, dynamic>{};
    for (var field in fields) {
      valuesMap[field.jsonKey] = field.controller?.value;
    }
    return valuesMap;
  }
}
