import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/models/journal_entry_fields.dart';
import '../widgets/drawer_listview.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final entry =
        ModalRoute.of(context)!.settings.arguments as JournalEntryFields;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(DateFormat.yMMMMEEEEd().format(entry.date!)),
        centerTitle: true,
      ),
      endDrawer: Drawer(child: DrawerView()),
      body: details(context, entry),
    );
  }

  Widget details(BuildContext context, JournalEntryFields entry) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(entry.title!,
                  style: Theme.of(context).textTheme.headline4),
            ),
          )
        ]),
        Row(children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                entry.body!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ]),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: Text('Rating: ${entry.rating}'))
          ],
        )
      ],
    );
  }
}
