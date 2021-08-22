import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:journal/models/journal_entry_fields.dart';

class JournalEntryForm extends StatefulWidget {
  const JournalEntryForm({Key? key}) : super(key: key);

  @override
  JournalEntryFormState createState() => JournalEntryFormState();
}

class JournalEntryFormState extends State<JournalEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryFields();
  int selectedValue = 1;
  List<int> ratingList = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  journalEntryFields.title = value!;
                },
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  journalEntryFields.body = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField<int>(
                value: selectedValue,
                validator: (value) {
                  if (value! < 1 || value > 4) {
                    return 'Please enter 1 to 4';
                  }
                  return null;
                },
                items: ratingList.map<DropdownMenuItem<int>>(
                  (int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    journalEntryFields.rating = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addDateTimeValue();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Entry Added'),
                    ));

                    String schema = await rootBundle.loadString('assets/schema_1.sql.txt');

                    final database = await openDatabase(
                      join(await getDatabasesPath(), 'journal.sqlit3.db'),
                      onCreate: (db, version) {
                        return db.execute(schema);
                      },
                      version: 1,
                    );

                    await database.transaction((txn) async {
                      await txn.rawInsert(
                        'INSERT INTO journal_entries(title, body, rating, date) VALUES(?,?,?,?)',
                        [
                          journalEntryFields.title,
                          journalEntryFields.body,
                          journalEntryFields.rating,
                          journalEntryFields.date.toString()
                        ],
                      );
                    });

                    await database.close();
                    Navigator.pushNamed(context, '/');
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addDateTimeValue() {
    journalEntryFields.date = DateTime.now();
  }
}
