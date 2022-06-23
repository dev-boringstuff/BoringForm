import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final form1Controller = BoringFormController();
  final form2Controller = BoringFormController();
  final textFieldController = BoringFieldController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('boring_form_builder example')),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            Card(
              child: BoringForm(
                controller: form1Controller,
                title: 'Form 1 title',
                subtitle: 'Form 1 subtitle',
                sections: [
                  BoringSection(
                    title: 'Section 1.1 title',
                    fields: const [
                      BoringTextField(
                        jsonKey: 'jsonKey1',
                        label: 'label1',
                        helperText: 'helperText1',
                      ),
                    ],
                  ),
                  BoringSection(
                    subtitle: 'Section 1.2 subtitle',
                    fields: [
                      const BoringTextField(
                        jsonKey: 'jsonKey2',
                        label: 'label2',
                        initialValue: 'initial value',
                      ),
                      BoringTextField(
                        jsonKey: 'jsonKey3',
                        label: 'label3',
                        controller: textFieldController,
                        initialValue: 'with given controller',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: BoringForm(
                controller: form2Controller,
                title: 'Form 2 title',
                sections: [
                  BoringSection(
                    title: 'Section 2.1 title',
                    fields: const [
                      BoringTextField(
                        jsonKey: 'jsonKey1',
                        label: 'label4',
                        helperText: 'helperText2',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      form1Controller.reset();
                    },
                    child: const Text('Reset 1'),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint(form1Controller.getValue().toString());
                    },
                    child: const Text('Get values 1'),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      form2Controller.reset();
                    },
                    child: const Text('Reset 2'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
