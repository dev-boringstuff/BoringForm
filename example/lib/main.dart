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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final BoringFormController formController1 = BoringFormController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView(
              children: [
                BoringForm(
                  controller: formController1,
                  sections: [
                    BoringSection(
                      boringFieldController: BoringFieldController(),
                      jsonKey: "section",
                      fields: [
                        BoringTexField(
                          jsonKey: "text1",
                          controller: BoringFieldController(),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  formController1.reset();
                },
                child: const Text('Reset 1'),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  debugPrint(formController1.valid.toString());
                },
                child: const Text('Get valid 1'),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  formController1.validate();
                },
                child: const Text('Validate 1'),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  debugPrint(formController1.value.toString());
                },
                child: const Text('Get values 1'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
