import 'package:flutter/material.dart';

import '../model/posts.dart';

class PostWidget extends StatelessWidget {
  final Posts post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'POST  #${post.id.toString().padLeft(3, '0')}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.person_outline,
                  size: 17,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  'User ${post.userId}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF73798C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              post.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.35,
                color: const Color(0xFF25293D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              post.body,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF73798C),
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
