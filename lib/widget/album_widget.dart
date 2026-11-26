import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';

class AlbumWidget extends StatelessWidget {
  final Albums albums;

  const AlbumWidget({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.sand,
                    AppColors.cream,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.photo_library_outlined,
                color: AppColors.forest,
                size: 27,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    albums.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ALBUM ${albums.id.toString().padLeft(3, '0')}  ·  USER ${albums.userId}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.brown,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.forest,
            ),
          ],
        ),
      ),
    );
  }
}
