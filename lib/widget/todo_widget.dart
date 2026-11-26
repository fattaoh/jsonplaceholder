import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/todos.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';

class TodoWidget extends StatelessWidget {
  final Todos todos;

  const TodoWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = todos.completed
        ? AppColors.forest
        : AppColors.brown;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            Icon(
              todos.completed
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: statusColor,
              size: 25,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todos.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: todos.completed
                          ? AppColors.brown
                          : AppColors.charcoal,
                      decoration: todos.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'TASK ${todos.id.toString().padLeft(3, '0')}  ·  USER ${todos.userId}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.brown,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                todos.completed ? 'DONE' : 'OPEN',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
