import 'package:flutter/material.dart';
import 'package:sophy/core/theme/colors.dart';
import 'package:sophy/features/presentation/widgets/cute_widgets.dart';

class CategoryGrid extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryGrid({super.key, required this.onCategorySelected});

  final List<String> categories = const [
    'Pop',
    'Rock',
    'Jazz',
    'Classical',
    'Hip Hop',
    'Electronic',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        // Generate cute pastel colors dynamically
        final colors = [
          AppColors.pastelPink, // Use new AppColors references
          AppColors.secondary,
          AppColors.tertiary,
          AppColors.accent1,
          AppColors.accent2,
        ];
        final color = colors[index % colors.length];

        return GestureDetector(
          onTap: () => onCategorySelected(category),
          child: CuteCard(
            padding: EdgeInsets.zero,
            color: color.withValues(alpha: 0.6),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  right: -20,
                  bottom: -10,
                  child: Transform.rotate(
                    angle: 0.4,
                    child: Icon(
                      Icons.music_note_rounded,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    category,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
