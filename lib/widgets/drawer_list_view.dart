import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          child: Text('Settings'),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        DarkModeSwitch()
      ],
    );
  }
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _dark = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _dark,
      title: const Text('Dark Mode'),
      onChanged: (bool value) {
        setState(() {
          _dark = value;
          print(value);
        });
      },
      secondary: const Icon(Icons.nightlight_outlined),
    );
  }
}
