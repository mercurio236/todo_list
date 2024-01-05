import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({required this.todo, required this.onDelete, super.key});

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        key: const ValueKey(0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, //ocupar a maior area possivel
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
                style: TextStyle(fontSize: 12),
              ),
              Text(
                todo.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              onDelete(todo);
            }),
            children: [
              SlidableAction(
                spacing: 0.25,
                onPressed: (context) {
                  onDelete(todo);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
      ),
    );
  }
}
