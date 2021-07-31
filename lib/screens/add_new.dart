import 'package:flutter/material.dart';
import '../widgets/drawer_list_view.dart';
import 'package:journal/widgets/journal_entry_form.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Journal Entry'),
        centerTitle: true,
      ),
      endDrawer: Drawer(child: DrawerView()),
      body: JournalEntryForm(),
    );
  }
}
