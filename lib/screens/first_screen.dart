import 'package:flutter/material.dart';
import 'drawer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      endDrawer: Drawer(child: DrawerView()),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to Journal'),
        addButton(context),
      ],
    ));
  }

  void pushAddNew(BuildContext context) {
    Navigator.pushNamed(context, 'addNew');
  }

  Widget addButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pushAddNew(context),
      child: Text('Add New Journal'),
    );
  }
}
