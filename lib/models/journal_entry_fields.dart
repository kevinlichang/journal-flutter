class JournalEntryFields {
  int? id;
  String? title;
  String? body;
  int? rating;
  DateTime? date;

  JournalEntryFields({this.id, this.title, this.body, this.rating, this.date});

  String toString() {
    return 'Id: $id, Title: $title, Body: $body, Rating: $rating, Date: $date';
  }
}
