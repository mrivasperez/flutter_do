import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class StorageService {
  static const _todosKey = 'todos';

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString(_todosKey);

    if (todosJson == null) {
      return [];
    }

    final List<dynamic> todoList = json.decode(todosJson);
    return todoList.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = json.encode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_todosKey, todosJson);
  }
}
