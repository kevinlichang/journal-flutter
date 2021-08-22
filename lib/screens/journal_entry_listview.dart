import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/models/journal.dart';
import 'package:journal/models/journal_entry_fields.dart';
import 'package:journal/widgets/welcome.dart';
import 'package:journal/widgets/layout_widgets.dart';

class JournalEntriesListScreen extends StatefulWidget {
  const JournalEntriesListScreen({Key? key}) : super(key: key);

  @override
  JournalEntriesListScreenState createState() =>
      JournalEntriesListScreenState();
}

class JournalEntriesListScreenState extends State<JournalEntriesListScreen> {
  Journal journal = Journal(entries: []);
  JournalEntryFields currentEntry = JournalEntryFields();

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    // await deleteDatabase(join(await getDatabasesPath(), 'journal.sqlit3.db'));

    String schema = await rootBundle.loadString('assets/schema_1.sql.txt');

    final database = await openDatabase(
      join(await getDatabasesPath(), 'journal.sqlit3.db'),
      onCreate: (db, version) {
        return db.execute(schema);
      },
      version: 1,
    );

    List<Map> journalRecords =
        await database.rawQuery('SELECT * FROM journal_entries');

    final journalEntries = journalRecords.map((record) {
      return JournalEntryFields(
        id: record['id'],
        title: record['title'],
        body: record['body'],
        rating: record['rating'],
        date: DateTime.parse(record['date']),
      );
    }).toList();

    setState(() {
      journal = Journal(entries: journalEntries);
      currentEntry = journal.entries[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: journal.isEmpty() ? 'Welcome' : 'Journal Entries',
      child:
          journal.isEmpty() ? welcome(context) : LayoutDecider(leftScreen: journalList(context, journal), rightScreen: horizontalDetails(context, currentEntry)) ,
    );
  }

  Widget journalList(BuildContext context, Journal journal) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${journal.entries[index].title}'),
          subtitle: Text(
              '${DateFormat.yMMMMEEEEd().format(journal.entries[index].date)}'),
          onTap: () {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              setState(() {
                currentEntry = journal.entries[index];
              });
            } else {
              Navigator.pushNamed(context, '/details', arguments: journal.entries[index]);
            }
          },
        );
      },
      itemCount: journal.entries.length,
    );
  }

  Widget horizontalDetails(BuildContext context, JournalEntryFields entry) {
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

