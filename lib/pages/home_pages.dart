import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/albums_tab.dart';
import 'package:jsonplaceholder/pages/tabs/comments_tab.dart';
import 'package:jsonplaceholder/pages/tabs/photos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';
import 'package:jsonplaceholder/pages/tabs/todos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/users_tab.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  static const _sections = [
    _Section('Posts', Icons.article_outlined, Icons.article_rounded),
    _Section('Comments', Icons.chat_bubble_outline, Icons.chat_bubble),
    _Section('Albums', Icons.photo_library_outlined, Icons.photo_library),
    _Section('Photos', Icons.image_outlined, Icons.image),
    _Section('Todos', Icons.task_alt_outlined, Icons.task_alt),
    _Section('Users', Icons.people_outline, Icons.people),
  ];

  static const _pages = [
    PostsTab(),
    CommentsTab(),
    AlbumsTab(),
    PhotosTab(),
    TodosTab(),
    UsersTab(),
  ];

  late final PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectSection(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;

            return Row(
              children: [
                if (isWide)
                  _Sidebar(
                    sections: _sections,
                    selectedIndex: _selectedIndex,
                    onSelected: _selectSection,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _TopBar(isWide: isWide),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() => _selectedIndex = index);
                          },
                          children: _pages,
                        ),
                      ),
                      if (!isWide)
                        _MobileNavigation(
                          sections: _sections,
                          selectedIndex: _selectedIndex,
                          onSelected: _selectSection,
                          compact: constraints.maxWidth < 560,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isWide;

  const _TopBar({required this.isWide});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 76,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 36 : 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE9EAF0))),
      ),
      child: Row(
        children: [
          if (!isWide) ...[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(Icons.data_object, color: Colors.white),
            ),
            const SizedBox(width: 12),
          ],
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'JSONPlaceholder',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'API DATA EXPLORER',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF85899B),
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isWide)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5FA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_done_outlined,
                    size: 17,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'REST API',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 14),
          CircleAvatar(
            radius: 19,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.person_outline,
              size: 20,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final List<_Section> sections;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _Sidebar({
    required this.sections,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF171B32),
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF6975F5),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.data_object, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API STUDIO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'JSONPlaceholder',
                    style: TextStyle(color: Color(0xFFA8ADC2), fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 42),
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 12),
            child: Text(
              'WORKSPACE',
              style: TextStyle(
                color: Color(0xFF7F849B),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),
          for (var index = 0; index < sections.length; index++)
            _SidebarItem(
              section: sections[index],
              selected: index == selectedIndex,
              onTap: () => onSelected(index),
            ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: const Row(
              children: [
                Icon(Icons.api, color: Color(0xFF9EA7FF), size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Explore public sample data',
                    style: TextStyle(
                      color: Color(0xFFD8DAE6),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final _Section section;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        color: selected ? const Color(0xFF30385A) : Colors.transparent,
        borderRadius: BorderRadius.circular(11),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11),
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 3,
                  height: selected ? 25 : 0,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9EA7FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 13),
                Icon(
                  selected ? section.activeIcon : section.icon,
                  size: 20,
                  color: selected
                      ? const Color(0xFFB7BEFF)
                      : const Color(0xFF9DA2B7),
                ),
                const SizedBox(width: 12),
                Text(
                  section.label,
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFFB9BDCC),
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavigation extends StatelessWidget {
  final List<_Section> sections;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool compact;

  const _MobileNavigation({
    required this.sections,
    required this.selectedIndex,
    required this.onSelected,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        height: 66,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE9EAF0))),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              for (var index = 0; index < sections.length; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _CompactNavigationItem(
                    section: sections[index],
                    selected: index == selectedIndex,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return NavigationBar(
      height: 68,
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: [
        for (final section in sections)
          NavigationDestination(
            icon: Icon(section.icon),
            selectedIcon: Icon(section.activeIcon),
            label: section.label,
          ),
      ],
    );
  }
}

class _CompactNavigationItem extends StatelessWidget {
  final _Section section;
  final bool selected;
  final VoidCallback onTap;

  const _CompactNavigationItem({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected
          ? theme.colorScheme.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Row(
            children: [
              Icon(
                selected ? section.activeIcon : section.icon,
                size: 19,
                color: selected
                    ? theme.colorScheme.primary
                    : const Color(0xFF85899B),
              ),
              const SizedBox(width: 7),
              Text(
                section.label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: selected
                      ? theme.colorScheme.primary
                      : const Color(0xFF686E80),
                  fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _Section(this.label, this.icon, this.activeIcon);
}
