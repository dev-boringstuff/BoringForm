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
    required this.row,
    this.xs = 12,
    this.sm = 12,
    this.md = 12,
    this.lg = 12,
  });

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
  BoringArrayField2 copyWith({void Function()? onChangedAux}) {
    return BoringArrayField2(
      jsonKey: jsonKey,
      label: label,
      helperText: helperText,
      initialValue: initialValue,
      controller:
          controller ?? BoringFieldController<List<Map<String, dynamic>>>(),
      onChanged: (value) {
        onChangedAux?.call();
        onChanged?.call(value);
      },
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

  void addRow() {
    setState(() {
      rows = rows
        ..add(widget.row.map((field) {
          BoringField newField = field.copyWith();
          newField.controller?.addListener(updateControllerValue);
          return newField;
        }).toList());
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

//TODO end this function
  void copyFromIndex(int targetIndex, {int? destinationIndex = -1}) {
    List<BoringField> newRow = widget.row.map((field) {
      BoringField newField = field.copyWith();
      newField.controller?.addListener(updateControllerValue);
      return newField;
    }).toList();
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
                  children: [
                    ...rows[index].map((field) {
                      return Expanded(child: field);
                    }).toList(),
                    IconButton(
                        onPressed: () => copyFromIndex(index),
                        icon: Icon(Icons.copy))
                  ],
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
    widget.controller?.shouldReset = false;
    widget.controller?.isResetting = true;
    setState(() {
      rows = [];
    });
    widget.controller?.isResetting = false;
  }

  @override
  void updateValid() {
    var valid = true;
    for (var row in rows) {
      for (var field in row) {
        field.controller?.getValid();
        valid &= field.controller?.valid ?? false;
      }
    }
    widget.controller?.valid = valid;
  }

  @override
  void validate() {
    widget.controller?.shouldValidate = false;
    widget.controller?.isValidating = true;
    for (var row in rows) {
      for (var field in row) {
        field.controller?.validate();
      }
    }
    widget.controller?.isValidating = false;
  }
}
