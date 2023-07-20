class Task {
  int? id;

  String? title;

  String? description;

  String? createdate;

  int? execute = 0;

  Task(
      {this.id,
       this.title,
       this.description,
       this.createdate,
       this.execute});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdate: json['createdate'],
      execute: json['execute']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdate': createdate,
        'execute': execute
      };
}
