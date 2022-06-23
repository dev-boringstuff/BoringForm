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
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.shouldReset && !widget.controller.isResetting) {
        _reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey<FormState>(),
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
}
