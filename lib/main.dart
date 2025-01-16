import 'package:flutter/material.dart';
import 'package:flutter_do/screens/todo_list_screen.dart';
import 'models/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: TodoListScreen(),
    );
  }
}


// Widget for displaying a single todo item
class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final Function(int) onToggle;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) => onToggle(todo.id),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(todo.id),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(todo.id),
          ),
        ],
      ),
    );
  }
}
