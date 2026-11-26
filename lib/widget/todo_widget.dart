import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/todos.dart';

class TodoWidget extends StatelessWidget {
  final Todos todos;
  const TodoWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: todos.completed
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            todos.completed ? Icons.check : Icons.circle_outlined,
            color: todos.completed
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(todos.title),
        subtitle: Text('Todo #${todos.id} · User #${todos.userId}'),
        isThreeLine: false,
        trailing: Text(
          todos.completed ? 'Selesai' : 'Belum',
          style: theme.textTheme.labelMedium?.copyWith(
            color: todos.completed
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}