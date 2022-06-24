import 'package:boring_form_builder/boring_form_builder.dart';
import 'package:flutter/material.dart';

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
        child: Row(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: BoringForm(
                      controller: form1Controller,
                      title: 'Boring form',
                      subtitle: 'Boring subtitle',
                      sections: [
                        BoringSection(
                          title: 'Identity',
                          jsonKey: 'identity',
                          fields: const [
                            BoringTextField(
                              jsonKey: 'name',
                              label: 'Name',
                              helperText: 'First name',
                              initialValue: 'Andrea',
                            ),
                            BoringTextField(
                              jsonKey: 'surname',
                              label: 'Surname',
                            ),
                            BoringPasswordField(
                              jsonKey: 'password',
                              label: 'Password',
                            ),
                          ],
                        ),
                        BoringSection(
                          title: 'Contacts',
                          jsonKey: 'contacts',
                          fields: const [
                            BoringTextField(
                              jsonKey: 'city',
                              label: 'city',
                              initialValue: 'Rome',
                            ),
                            BoringTextField(
                              jsonKey: 'cap',
                              label: 'cap',
                              helperText: 'xxxxx',
                            ),
                          ],
                        ),
                        BoringSection(
                          title: 'Buggy section 1',
                          jsonKey: 'bug',
                          fields: const [
                            BoringTextField(
                              jsonKey: 'bug1',
                              label: 'bug1',
                            ),
                            BoringTextField(
                              jsonKey: 'bug2',
                              label: 'bug2',
                            ),
                          ],
                        ),
                        BoringSection(
                          title: 'Buggy section 2',
                          fields: const [
                            BoringTextField(
                              jsonKey: 'bug',
                              label: 'bug',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: BoringForm(
                      controller: form2Controller,
                      title: 'Form 2',
                      sections: [
                        BoringSection(
                          fields: const [
                            BoringTextField(
                              jsonKey: 'test',
                              label: 'Test field',
                              obscureText: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 4),
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
          ],
        ),
      ),
    );
  }
}
