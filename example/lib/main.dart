import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: SectionTest(),
    );
  }
}

class SectionTest extends StatelessWidget {
  SectionTest({Key? key}) : super(key: key);
  BoringFieldController controller = BoringFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BoringSection(
      boringFieldController: controller,
      jsonKey: "section",
      fields: [
        BoringTexField(
          jsonKey: "text1",
          controller: BoringFieldController(),
        )
      ],
    ));
  }
}
