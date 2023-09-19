class TodoModel {
  final int id;
  final String title;
  final String description;
  final String time;
  final int favourite;
  final int completed;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.favourite,
    required this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      favourite: json['favourite'],
      completed: json['completed'],
    );
  }
}
