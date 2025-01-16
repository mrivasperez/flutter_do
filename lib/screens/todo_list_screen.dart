// lib/screens/todo_list_screen.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_item_widget.dart';
import '../services/storage_service.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  int _nextTodoId = 1;
  final _storageService = StorageService(); // Create StorageService instance

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Load todos on app start
  }

  // Load todos from storage
  Future<void> _loadTodos() async {
    final loadedTodos = await _storageService.loadTodos();
    setState(() {
      _todos.addAll(loadedTodos);
      if (_todos.isNotEmpty) {
        _nextTodoId = _todos.last.id + 1;
      }
    });
  }

  // Function to add a new task
  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        String newTodoTitle = ""; // Variable to store input from the dialog

        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            autofocus: true, // Automatically focus on the text field
            onChanged: (value) {
              newTodoTitle = value;
            },
            onSubmitted: (value) {
              _submitTodo(newTodoTitle);
            },
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _submitTodo(newTodoTitle);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _submitTodo(String newTodoTitle) async {
    if (newTodoTitle.isNotEmpty) {
      setState(() {
        _todos.add(Todo(id: _nextTodoId++, title: newTodoTitle));
      });
    }
    Navigator.of(context).pop();
    await _storageService.saveTodos(_todos);
  }

  // Function to toggle task completion status
  void _toggleTodo(int id) async {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isCompleted = !todo.isCompleted;
      _sortTodos(); // Sort after toggling
    });
    await _storageService.saveTodos(_todos);
  }

  // Function to edit task title
  void _editTodo(int id) {
    showDialog(
      context: context,
      builder: (context) {
        String editedTodoTitle =
            _todos.firstWhere((todo) => todo.id == id).title;

        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: editedTodoTitle),
            onChanged: (value) {
              editedTodoTitle = value;
            },
            onSubmitted: (value) {
              _updateTodoTitle(id, editedTodoTitle);
            },
            decoration: const InputDecoration(hintText: 'Enter new task title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateTodoTitle(id, editedTodoTitle);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _updateTodoTitle(int id, String updatedTitle) async {
    if (updatedTitle.isNotEmpty) {
      setState(() {
        _todos.firstWhere((todo) => todo.id == id).title = updatedTitle;
      });
    }
    Navigator.of(context).pop();
    await _storageService.saveTodos(_todos);
  }

  // Function to delete a task
  void _deleteTodo(int id) async {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
      // No need to sort after deleting
    });
    await _storageService.saveTodos(_todos);
  }

  // Function to delete all completed tasks
  void _deleteCompletedTodos() async {
    setState(() {
      _todos.removeWhere((todo) => todo.isCompleted);
      // No need to sort after deleting
    });
    await _storageService.saveTodos(_todos);
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
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteCompletedTodos,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return TodoItemWidget(
            key: ValueKey(todo.id),
            todo: todo,
            onToggle: _toggleTodo,
            onEdit: _editTodo,
            onDelete: _deleteTodo,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
