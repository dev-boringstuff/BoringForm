import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter/src/widgets/framework.dart';

class BoringArrayField2 extends StatefulWidget
    implements BoringField<List<Map<String, dynamic>>> {
  BoringArrayField2({
    super.key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.onChanged,
    required List<BoringField> row,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  })  : row = row.map((field) {
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
  final List<Map<String, dynamic>>? initialValue;
  @override
  final BoringFieldController<List<Map<String, dynamic>>>? controller;
  @override
  final void Function(List<Map<String, dynamic>>?)? onChanged;
  @override
  final int xs;
  @override
  final int sm;
  @override
  final int md;
  @override
  final int lg;

  final List<BoringField> row;

  @override
  BoringArrayField2 copyWith() {
    return BoringArrayField2(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller:
          controller ?? BoringFieldController<List<Map<String, dynamic>>>(),
      onChanged: onChanged,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      row: row,
    );
  }

  @override
  State<StatefulWidget> createState() => _BorinArrayFieldState();
}

class _BorinArrayFieldState extends State<BoringArrayField2>
    implements BoringFieldStateWithValidation<List<Map<String, dynamic>>> {
  List<List<BoringField>> rows = [];

  void addRow() {
    setState(() {
      //TODO fix this
      rows = rows..add(widget.row);
    });
  }

  void removeRow(int index) {
    setState(() {
      rows = rows..removeAt(index);
    });
  }

  bool validateRow(List<BoringField> row) {
    for (var field in row) {
      if (!field.controller!.valid) {
        return false;
      }
    }
    return true;
  }

  Map<String, dynamic> getRowValue(List<BoringField> row) {
    Map<String, dynamic> value = {};
    for (var field in row) {
      value[field.jsonKey] = field.controller?.value;
    }
    return value;
  }

  List<Map<String, dynamic>> getValue() {
    List<Map<String, dynamic>> value = [];
    for (var row in rows) {
      value.add(getRowValue(row));
    }
    return value;
  }

  void updateControllerValue() {
    widget.controller?.value = getValue();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: Column(children: [
        IconButton(onPressed: addRow, icon: Icon(Icons.add)),
        Expanded(
          child: ListView.builder(
            itemCount: rows.length,
            itemBuilder: (BuildContext context, int index) {
              return ConstrainedBox(
                constraints:
                    const BoxConstraints(minWidth: 800, maxWidth: 1200),
                child: Row(
                  children: rows[index]
                      .map((field) => Expanded(child: field))
                      .toList(),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  @override
  void reset() {
    setState(() {
      rows = [widget.row];
    });
  }

  @override
  void updateValid() {
    // TODO: implement updateValid
  }

  @override
  void validate() {
    // TODO: implement validate
  }
}
