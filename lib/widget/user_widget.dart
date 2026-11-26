import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;

  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = user.name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(label: Text('#${user.id}')),
              ],
            ),
            const SizedBox(height: 12),
            _UserDetail(
              icon: Icons.email_outlined,
              text: user.email,
            ),
            _UserDetail(
              icon: Icons.phone_outlined,
              text: user.phone,
            ),
            _UserDetail(
              icon: Icons.language_outlined,
              text: user.website,
            ),
            const Divider(height: 24),
            _UserDetail(
              icon: Icons.location_on_outlined,
              text:
                  '${user.address.street}, ${user.address.suite}, ${user.address.city} ${user.address.zipcode}',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 2),
              child: Text(
                'Koordinat: ${user.address.geo.lat}, ${user.address.geo.lng}',
                style: theme.textTheme.bodySmall,
              ),
            ),
            _UserDetail(
              icon: Icons.business_outlined,
              text: user.company.name,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.company.catchPhrase,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(user.company.bs, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const _UserDetail({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 10),
          Expanded(child: SelectableText(text)),
        ],
      ),
    );
  }
}