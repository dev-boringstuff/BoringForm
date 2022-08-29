import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

class BoringSection extends BoringField {
  BoringSection(
      {required this.fields,
      this.title,
      this.description,
      this.subtitle,
      required super.boringFieldController,
      required super.jsonKey});

  List<BoringField> fields;
  String? title, subtitle, description;

  @override
  _BoringSectionState createState() => _BoringSectionState();

  @override
  bool get isValid => fields.every((element) => element.isValid);

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
    for (var element in fields) {
      sectionValue[element.jsonKey] = element.value;
    }
  }
}

class _BoringSectionState extends BoringFieldState<BoringSection> {
  double sectionWidth = double.infinity;

  @override
  Widget build(BuildContext context) {
    const fieldMargin = 6.0;
    return Builder(
      builder: (context) {
        // Setto la variabile della width basandomi sulla width renderizzata
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox = context.findRenderObject() as RenderBox;
          setState(() {
            sectionWidth = renderBox.size.width;
          });
        });

        return SizedBox(
          width: double.infinity,
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
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calcolo la width dei field
                  return Wrap(
                    children: List.generate(
                      widget.fields.length,
                      (index) => Container(
                        width: (sectionWidth /
                                12 *
                                (constraints.maxWidth >= 1240
                                    ? widget.fields[index].lg
                                    : constraints.maxWidth >= 905
                                        ? widget.fields[index].md
                                        : constraints.maxWidth >= 600
                                            ? widget.fields[index].sm
                                            : widget.fields[index].xs) -
                            fieldMargin * 2),
                        margin:
                            const EdgeInsets.symmetric(horizontal: fieldMargin),
                        child: widget.fields[index],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void reset() {
    for (var field in widget.fields) {
      field.boringFieldController.reset();
    }
  }

  @override
  void validate() {
    for (var field in widget.fields) {
      field.boringFieldController.validate();
    }
  }
}
