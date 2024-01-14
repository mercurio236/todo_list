class Todo {
  Todo({required this.title, required this.date});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['date']);

  String title;
  DateTime date;

  Map<String, dynamic> toJson() {
    // aqui estou informado o tipo do dado no map
    return {
      'title': title,
      'date':
          date.toIso8601String(), //quando for data usar esse tipo de conversão
    };
  }
}
