class Task {
  static const String collectionName = 'Tasks';

  String? id;
  String? title;
  String? desc;
  String? date;
  bool? isDone;

  Task({this.id = "", this.title, this.desc, this.date, this.isDone = false});

  /// From Firestore
  Task.fromJson(Map<String, Object?> json)
      : this(
            id: json['id'] as String?,
            title: json['title'] as String?,
            desc: json['desc'] as String?,
            date: json['date'] as String?,
            isDone: json['isDone'] as bool?);

  /// To Firestore
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'isDone': isDone
    };
  }
}
