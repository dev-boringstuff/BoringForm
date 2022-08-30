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
  final BoringController formController1 = BoringController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView(
              children: [
                BoringForm(
                  title: 'Titolo',
                  controller: formController1,
                  description: 'The most beautiful form',
                  sections: [
                    BoringSection(
                      title: 'Title',
                      controller: BoringController(),
                      jsonKey: "section",
                      fields: [
                        BoringTexField(
                          jsonKey: "text1",
                          controller: BoringController(),
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
                  debugPrint(formController1.isValid().toString());
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
                  debugPrint(formController1.getValue().toString());
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
