import 'package:flutter/material.dart';
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

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  int _nextTodoId = 1;

  // Function to add a new task
  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        String newTodoTitle = ""; // Variable to store input from the dialog

        return AlertDialog(
          title: Text('Add Todo'),
          content: TextField(
            autofocus: true, // Automatically focus on the text field
            onChanged: (value) {
              newTodoTitle = value;
            },
            onSubmitted: (value) {
              _submitTodo(newTodoTitle);
            },
            decoration: InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _submitTodo(newTodoTitle);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _submitTodo(String newTodoTitle) {
    if (newTodoTitle.isNotEmpty) {
      setState(() {
        _todos.add(Todo(id: _nextTodoId++, title: newTodoTitle));
      });
    }
    Navigator.of(context).pop();
  }

  // Function to toggle task completion status
  void _toggleTodo(int id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isCompleted = !todo.isCompleted;
      _sortTodos(); // Sort after toggling
    });
  }

  // Function to edit task title
  void _editTodo(int id) {
    showDialog(
      context: context,
      builder: (context) {
        String editedTodoTitle =
            _todos.firstWhere((todo) => todo.id == id).title;

        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: editedTodoTitle),
            onChanged: (value) {
              editedTodoTitle = value;
            },
            onSubmitted: (value) {
              _updateTodoTitle(id, editedTodoTitle);
            },
            decoration: InputDecoration(hintText: 'Enter new task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateTodoTitle(id, editedTodoTitle);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _updateTodoTitle(int id, String updatedTitle) {
    if (updatedTitle.isNotEmpty) {
      setState(() {
        _todos.firstWhere((todo) => todo.id == id).title = updatedTitle;
      });
    }
    Navigator.of(context).pop();
  }

  // Function to delete a task
  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  // Function to delete all completed tasks
  void _deleteCompletedTodos() {
    setState(() {
      _todos.removeWhere((todo) => todo.isCompleted);
    });
  }

  // Function to sort todos
  void _sortTodos() {
    _todos.sort((a, b) {
      // Sort by completion status first (uncompleted before completed)
      if (!a.isCompleted && b.isCompleted) {
        return -1;
      }
      if (a.isCompleted && !b.isCompleted) {
        return 1;
      }
      // If completion status is the same, sort by ID (or any other criteria)
      return a.id.compareTo(b.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: _deleteCompletedTodos,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return TodoItemWidget(
            todo: todo,
            onToggle: _toggleTodo,
            onEdit: _editTodo,
            onDelete: _deleteTodo,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
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
