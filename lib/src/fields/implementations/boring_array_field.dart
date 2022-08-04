import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringArrayField extends StatefulWidget
    implements BoringField<List<Map<String, dynamic>>> {
  const BoringArrayField({
    super.key,
    required this.jsonKey,
    required this.label,
    this.helperText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.expandable = false,
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
  final bool expandable;

  final List<BoringField> row;

  @override
  BoringArrayField copyWith({void Function()? onChangedAux}) {
    return BoringArrayField(
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

class _BorinArrayFieldState extends State<BoringArrayField>
    implements BoringFieldStateWithValidation<List<Map<String, dynamic>>> {
  List<List<BoringField>> rows = [];
  double fieldWidth = double.infinity;
  bool isArrayExpanded = true;

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
    return widget.expandable
        ? ExpansionPanelList(
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                isArrayExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return _arrayHead();
                },
                body: _arrayBody(),
                isExpanded: isArrayExpanded,
              ),
            ],
          )
        : Column(
            children: [
              _arrayHead(),
              _arrayBody(),
            ],
          );
  }

  Widget _arrayHead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(onPressed: addRow, icon: const Icon(Icons.add)),
          ],
        ),
        widget.helperText != null
            ? Text(
                widget.helperText!,
                style: Theme.of(context).textTheme.headline6,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _arrayBody() {
    const fieldMargin = 6.0;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: rows.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final renderBox = context.findRenderObject() as RenderBox;
                    setState(() {
                      fieldWidth = renderBox.size.width;
                    });
                  });

                  return Wrap(
                    children: List.generate(
                      rows[index].length,
                      (i) => Container(
                        width: (fieldWidth /
                                12 *
                                (constraints.maxWidth >= 1240
                                    ? rows[index][i].lg
                                    : constraints.maxWidth >= 905
                                        ? rows[index][i].md
                                        : constraints.maxWidth >= 600
                                            ? rows[index][i].sm
                                            : rows[index][i].xs) -
                            fieldMargin * 2),
                        margin:
                            const EdgeInsets.symmetric(horizontal: fieldMargin),
                        child: rows[index][i],
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () => copyFromIndex(index),
              icon: const Icon(Icons.copy),
            ),
          ],
        );
      },
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
