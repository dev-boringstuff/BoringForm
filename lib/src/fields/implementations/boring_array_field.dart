import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:boring_form_builder/src/boring_support.dart';
import 'package:boring_form_builder/src/fields/boring_field_state.dart';
import 'package:flutter/material.dart';

class BoringArrayField extends BoringField<List<Map<String, dynamic>>> {
  BoringArrayField({
    super.initialValue,
    super.validator,
    required super.controller,
    super.title,
    super.helperText,
    required super.jsonKey,
    super.onChanged,
    this.expandable = false,
    required this.fields,
    super.key,
    super.xs,
    super.sm,
    super.md,
    super.lg,
  });

  final bool expandable;
  final List<BoringField> fields;

  @override
  List<Map<String, dynamic>> get value => [];

  @override
  bool get isValid {
    return false;
  }

  @override
  BoringFieldState<BoringArrayField, List<Map<String, dynamic>>>
      createState() => _BoringArrayFieldState();

  @override
  set setValue(List<Map<String, dynamic>>? value) {
    supportValue.value = value;
  }

  final BoringSupportValue<List<Map<String, dynamic>>> supportValue =
      BoringSupportValue();
}

class _BoringArrayFieldState
    extends BoringFieldState<BoringArrayField, List<Map<String, dynamic>>> {
  String? errorText;
  bool isArrayExpanded = true;
  List<List<BoringField>> rows = [];

  @override
  void initState() {
    super.initState();

    widget.setValue = widget.initialValue;
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
              widget.title ?? '',
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(onPressed: _addRow, icon: const Icon(Icons.add)),
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
                  return Wrap(
                    children: List.generate(
                      rows[index].length,
                      (i) => Container(
                        width: (constraints.maxWidth /
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
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.copy),
            ),
          ],
        );
      },
    );
  }

  void _addRow() {
    setState(() {
      rows = rows
        ..add(widget.fields.map((field) {
          BoringController newController = field.generateNewController();
          field.controller = newController;
          return field;
        }).toList());
    });
  }

  @override
  void setValue(List<Map<String, dynamic>>? newValue) {
    throw UnimplementedError();
  }

  @override
  void validate() {
    for (final row in rows) {
      for (final field in row) {
        field.controller.validate();
      }
    }
  }

  @override
  void reset() {
    widget.setValue = widget.initialValue;
  }
}
