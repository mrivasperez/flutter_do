// Todo data model
class Todo {
  int id;
  String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
