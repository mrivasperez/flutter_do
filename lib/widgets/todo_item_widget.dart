import 'package:flutter/material.dart';
import '../models/todo.dart';

// Widget for displaying a single todo item
class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final Todo todo;
  final Function(int) onToggle;
  final Function(int) onEdit;
  final Function(int) onDelete;

  @override
  TodoItemWidgetState createState() => TodoItemWidgetState();
}

class TodoItemWidgetState extends State<TodoItemWidget> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      child: ListTile(
        leading: Checkbox(
          value: widget.todo.isCompleted,
          onChanged: (value) async {
            if (value == true) {
              // Fade out when checked
              setState(() {
                _opacity = 0.5;
              });
              await Future.delayed(const Duration(milliseconds: 300));
            }
            widget.onToggle(widget.todo.id); // Toggle the state
            if (value == false) {
              // Fade in when unchecked
              setState(() {
                _opacity = 1.0;
              });
            }
          },
        ),
        title: Text(
          widget.todo.title,
          style: TextStyle(
            decoration:
                widget.todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => widget.onEdit(widget.todo.id),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => widget.onDelete(widget.todo.id),
            ),
          ],
        ),
      ),
    );
  }
}
