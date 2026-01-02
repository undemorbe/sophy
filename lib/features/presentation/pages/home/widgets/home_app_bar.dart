import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';
import 'package:sophy/l10n/app_localizations.dart';

class HomeAppBar extends StatelessWidget {
  final bool isMobile;
  const HomeAppBar({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: true,
      pinned: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          AppLocalizations.of(context)!.homepage_appbar(isMobile ? '1' : '2'),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.15),
                theme.scaffoldBackgroundColor,
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: GlassContainer(
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(50),
              child: GestureDetector(
                onTap: () => context.push('/profile'),
                child: Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
