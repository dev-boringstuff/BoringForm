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
                          fields: [
                            BoringTextField(
                              jsonKey: 'name',
                              label: 'Name',
                              helperText: 'First name',
                              initialValue: 'Andrea',
                              validator: (v) {
                                if ((v?.length ?? 0) > 25) {
                                  return 'Name should be less than 25 chars';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const BoringTextField(
                              jsonKey: 'surname',
                              label: 'Surname',
                            ),
                            BoringPasswordField(
                              jsonKey: 'password',
                              label: 'Password',
                              validator: (v) {
                                if ((v?.length ?? 0) > 25) {
                                  return 'Password should be less than 25 chars';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        BoringSection(
                          title: 'Contacts',
                          jsonKey: 'contacts',
                          fields: [
                            const BoringTextField(
                              jsonKey: 'city',
                              label: 'city',
                              initialValue: 'Rome',
                            ),
                            BoringIntField(
                              jsonKey: 'cap',
                              label: 'cap',
                              initialValue: 28060,
                              helperText: 'xxxxx',
                              validator: (v) {
                                if ((v?.length ?? 0) != 5) {
                                  return 'cap should be long 5 chars';
                                } else {
                                  return null;
                                }
                              },
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
                          fields: [
                            BoringTextField(
                              jsonKey: 'test',
                              label: 'Test field',
                              obscureText: true,
                              validator: (v) {
                                if ((v?.length ?? 0) <= 5) {
                                  return 'bug should be longer than 5 chars';
                                } else {
                                  return null;
                                }
                              },
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
                    debugPrint(form1Controller.valid.toString());
                  },
                  child: const Text('Get valid 1'),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    form1Controller.validate();
                  },
                  child: const Text('Validate 1'),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    debugPrint(form1Controller.value.toString());
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
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    debugPrint(form2Controller.valid.toString());
                  },
                  child: const Text('Get valid 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
