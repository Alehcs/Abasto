import 'package:flutter/material.dart';

class FilterPills extends StatelessWidget {
  final int selected;
  final List<String> filters;
  final ValueChanged<int> onSelect;

  const FilterPills({
    super.key,
    required this.selected,
    required this.filters,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: List.generate(filters.length, (i) {
          final isSelected = i == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.surface,
                  borderRadius: BorderRadius.circular(100),
                  border: isSelected
                      ? null
                      : Border.all(color: colors.outlineVariant),
                ),
                child: Text(
                  filters[i],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: isSelected ? colors.onPrimary : colors.onSurface,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
