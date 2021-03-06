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
                              lg: 4,
                              md: 6,
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
                              lg: 4,
                              md: 6,
                              jsonKey: 'surname',
                              label: 'Surname',
                            ),
                            BoringPasswordField(
                              lg: 4,
                              md: 6,
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
                            BoringDateField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'key1',
                              label: 'label1',
                              initialValue: DateTime.now(),
                              locale: const Locale('it'),
                              dateFormat: 'dd/MM/yyyy',
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ),
                            const BoringTextField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'key2',
                              label: 'label2',
                            ),
                            const BoringDropdown(
                              lg: 4,
                              md: 6,
                              jsonKey: 'dropdown',
                              label: 'dropdown',
                              required: 'Required',
                              items: <DropdownMenuItem<String>>[
                                DropdownMenuItem<String>(
                                  value: 'One',
                                  child: Text('One'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Two',
                                  child: Text('Two'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Free',
                                  child: Text('Free'),
                                ),
                              ],
                            ),
                            const BoringCheckbox(
                              jsonKey: 'key4',
                              label: 'label4',
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
                              initialValue: 2806,
                              helperText: 'xxxxx',
                              validator: (v) {
                                if ((v?.toString().length ?? 0) != 5) {
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
