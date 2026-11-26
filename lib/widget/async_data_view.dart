import 'package:flutter/material.dart';
import 'package:jsonplaceholder/theme/app_colors.dart';

class AsyncDataView<T> extends StatefulWidget {
  final Future<List<T>> Function() onFetch;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final String Function(T item) searchText;
  final String title;

  const AsyncDataView({
    super.key,
    required this.onFetch,
    required this.itemBuilder,
    required this.searchText,
    required this.title,
  });

  @override
  State<AsyncDataView<T>> createState() => _AsyncDataViewState<T>();
}

class _AsyncDataViewState<T> extends State<AsyncDataView<T>> {
  late Future<List<T>> _future;
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _future = widget.onFetch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() {
    final future = widget.onFetch();
    setState(() {
      _future = future;
    });

    return future.then<void>(
      (_) {},
      onError: (Object error, StackTrace stackTrace) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal memperbarui ${widget.title}: $error'),
            ),
          );
        }
      },
    );
  }

  String get _description => switch (widget.title) {
    'Posts' => 'Cerita dan pembaruan terbaru dari komunitas.',
    'Comments' => 'Percakapan yang menanggapi setiap post.',
    'Albums' => 'Kumpulan album foto dari semua pengguna.',
    'Photos' => 'Jelajahi koleksi foto dan pratinjaunya.',
    'Todos' => 'Daftar tugas beserta status penyelesaiannya.',
    'Users' => 'Profil, kontak, dan informasi setiap pengguna.',
    _ => 'Jelajahi data dari JSONPlaceholder.',
  };

  IconData get _icon => switch (widget.title) {
    'Posts' => Icons.article_outlined,
    'Comments' => Icons.chat_bubble_outline,
    'Albums' => Icons.photo_library_outlined,
    'Photos' => Icons.image_outlined,
    'Todos' => Icons.task_alt_outlined,
    'Users' => Icons.people_outline,
    _ => Icons.data_object,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<T>>(
      future: _future,
      builder: (context, snapshot) {
        final items = snapshot.data ?? <T>[];
        final visibleItems = _query.isEmpty
            ? items
            : items
                  .where(
                    (item) => widget
                        .searchText(item)
                        .toLowerCase()
                        .contains(_query.toLowerCase()),
                  )
                  .toList();

        return Column(
          children: [
            _buildHeader(theme, items.length, visibleItems.length),
            Expanded(
              child: switch (snapshot.connectionState) {
                ConnectionState.waiting => _buildLoading(theme),
                _ when snapshot.hasError => _buildMessage(
                  theme,
                  icon: Icons.cloud_off_outlined,
                  title: 'Data belum bisa dimuat',
                  message: 'Periksa koneksi internet lalu coba lagi.',
                  action: 'Coba lagi',
                  onAction: _handleRefresh,
                ),
                _ when items.isEmpty => _buildMessage(
                  theme,
                  icon: Icons.inbox_outlined,
                  title: 'Belum ada data',
                  message:
                      'Belum ada ${widget.title.toLowerCase()} untuk ditampilkan.',
                  action: 'Muat ulang',
                  onAction: _handleRefresh,
                ),
                _ when visibleItems.isEmpty => _buildMessage(
                  theme,
                  icon: Icons.search_off,
                  title: 'Tidak ada hasil',
                  message:
                      'Coba kata kunci lain untuk mencari ${widget.title.toLowerCase()}.',
                  action: 'Hapus pencarian',
                  onAction: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                ),
                _ => _buildList(visibleItems),
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme, int total, int visible) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 12),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(_icon, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: AppColors.charcoal,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.charcoal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (total > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.sand),
                      ),
                      child: Text(
                        visible == total ? '$total items' : '$visible / $total',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.sand),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.charcoal.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Cari ${widget.title.toLowerCase()}...',
                    hintStyle: const TextStyle(color: AppColors.brown),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.brown,
                      size: 21,
                    ),
                    suffixIcon: IconButton(
                      tooltip: 'Muat ulang',
                      onPressed: _handleRefresh,
                      icon: const Icon(Icons.refresh_rounded),
                      color: theme.colorScheme.primary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Memuat ${widget.title.toLowerCase()}...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String message,
    required String action,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.sand),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 38, color: theme.colorScheme.primary),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.brown,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: onAction,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(action),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<T> items) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(26, 8, 26, 28),
        itemCount: items.length,
        itemBuilder: (context, index) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: widget.itemBuilder(context, items[index], index),
            ),
          ),
        ),
      ),
    );
  }
}
