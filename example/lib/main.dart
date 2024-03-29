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
  final form1Controller = BoringController<Map<String, dynamic>>();
  final form2Controller = BoringController<Map<String, dynamic>>();
  final textFieldController = BoringController<String>();

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
                          controller: BoringController(),
                          fields: [
                            BoringTextField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'name',
                              title: 'Name',
                              helperText: 'First name',
                              initialValue: 'Andrea',
                              validator: (v) {
                                if ((v?.length ?? 0) > 25) {
                                  return 'Name should be less than 25 chars';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) =>
                                  debugPrint('Name changed: $value'),
                              controller: BoringController(),
                            ),
                            BoringTextField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'surname',
                              title: 'Surname',
                              controller: BoringController(),
                            ),
                            BoringPasswordField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'password',
                              title: 'Password',
                              validator: (v) {
                                if ((v?.length ?? 0) > 25) {
                                  return 'Password should be less than 25 chars';
                                } else {
                                  return null;
                                }
                              },
                              controller: BoringController(),
                            ),
                            BoringDateField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'key1',
                              title: 'label1',
                              initialValue: DateTime.now(),
                              locale: const Locale('it'),
                              dateFormat: 'dd/MM/yyyy',
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              controller: BoringController(),
                            ),
                            BoringTextField(
                              lg: 4,
                              md: 6,
                              jsonKey: 'key2',
                              title: 'label2',
                              controller: BoringController(),
                            ),
                            BoringDropdown(
                              lg: 4,
                              md: 6,
                              jsonKey: 'dropdown',
                              title: 'dropdown',
                              required: true,
                              items: const <DropdownMenuItem<String>>[
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
                              controller: BoringController(),
                            ),
                            BoringCheckbox(
                              initialValue: true,
                              jsonKey: 'key4',
                              title: 'label4',
                              controller: BoringController(),
                            ),
                          ],
                        ),
                        BoringSection(
                          title: 'Contacts',
                          jsonKey: 'contacts',
                          controller: BoringController(),
                          fields: [
                            BoringTextField(
                              jsonKey: 'city',
                              title: 'city',
                              initialValue: 'Rome',
                              controller: BoringController(),
                            ),
                            BoringIntField(
                              jsonKey: 'cap',
                              title: 'cap',
                              initialValue: 2806,
                              helperText: 'xxxxx',
                              validator: (v) {
                                if (v.toString().length != 5) {
                                  return 'cap should be long 5 chars';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: ((value) {
                                debugPrint("CAP changed: $value");
                              }),
                              controller: BoringController(),
                            ),
                            BoringDoubleField(
                              jsonKey: 'double',
                              title: 'double',
                              initialValue: 5.5,
                              controller: BoringController(),
                            ),
                            BoringArrayField(
                              expandable: true,
                              jsonKey: 'array',
                              title: 'Array field',
                              fields: [
                                BoringIntField(
                                  lg: 6,
                                  md: 6,
                                  sm: 6,
                                  xs: 6,
                                  validator: (v) => (v ?? 0) < 10
                                      ? 'Must be greater than 10'
                                      : null,
                                  jsonKey: 'int',
                                  title: 'int',
                                  controller: BoringController(),
                                ),
                                BoringPasswordField(
                                  lg: 6,
                                  md: 6,
                                  sm: 6,
                                  xs: 6,
                                  jsonKey: 'password',
                                  title: 'Password',
                                  validator: (v) {
                                    if ((v?.length ?? 0) > 25) {
                                      return 'Password should be less than 25 chars';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: BoringController(),
                                ),
                              ],
                              controller: BoringController(),
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
                          jsonKey: 'requiredKey',
                          controller: BoringController(),
                          fields: [
                            BoringTextField(
                              jsonKey: 'test',
                              title: 'Test field',
                              validator: (v) {
                                if ((v?.length ?? 0) <= 5) {
                                  return 'bug should be longer than 5 chars';
                                } else {
                                  return null;
                                }
                              },
                              controller: BoringController(),
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
                    debugPrint(form1Controller.isValid().toString());
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
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    debugPrint(form2Controller.isValid().toString());
                  },
                  child: const Text('Get valid 2'),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    form2Controller.validate();
                  },
                  child: const Text('Validate 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
