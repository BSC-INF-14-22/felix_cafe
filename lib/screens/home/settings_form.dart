import 'package:felix_cafe/models/user.dart' as app_model;
import 'package:felix_cafe/models/user.dart';
import 'package:felix_cafe/services/database.dart';
import 'package:felix_cafe/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:felix_cafe/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // Form state
  String _currentName = '';
  String _currentsugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<app_model.User?>(context);

    if (user == null) {
      return const Center(child: Text("No user found"));
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

          return Form(
            key: _formkey,
            child: Column(
              children: [
                const Text(
                  'Update texture settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),

                // Name field
                TextFormField(
                  initialValue: userData.name,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter name'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) =>
                      setState(() => _currentName = value),
                ),
                const SizedBox(height: 20.0),

                // Dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentsugars.isNotEmpty
                      ? _currentsugars
                      : userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _currentsugars = value.toString());
                  },
                ),
                const SizedBox(height: 20.0),

                // Slider
                Slider(
                  value: (_currentStrength == 100
                          ? userData.strength
                          : _currentStrength)
                      .toDouble(),
                  activeColor: Colors.brown[_currentStrength],
                  inactiveColor: Colors.brown[_currentStrength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),
                const SizedBox(height: 20.0),

                // Submit button
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentsugars.isNotEmpty
                            ? _currentsugars
                            : userData.sugars,
                        _currentName.isNotEmpty
                            ? _currentName
                            : userData.name,
                        _currentStrength != 100
                            ? _currentStrength
                            : userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
