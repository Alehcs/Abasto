import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/categories.dart';
import '../../../../core/constants/list_types.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../features/lists/domain/entities/category_entity.dart';
import '../../../../features/lists/domain/entities/shopping_item.dart';
import '../../../../features/lists/domain/entities/shopping_list.dart';
import '../../../../features/lists/presentation/providers/shopping_providers.dart';

class HistoryDetailPage extends ConsumerWidget {
  const HistoryDetailPage({super.key, required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(shoppingListProvider(listId));
    final items = ref.watch(listItemsProvider(listId));
    final categories = ref.watch(categoriesProvider);
    final canDelete = list.valueOrNull?.canDelete ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de compra'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Duplicar lista',
            onPressed: () async {
              final newListId = await ref
                  .read(shoppingRepositoryProvider)
                  .duplicateList(listId);
              if (context.mounted) {
                context.push('/lists/$newListId/shopping');
              }
            },
            icon: const Icon(Icons.content_copy_rounded),
          ),
          if (canDelete)
            IconButton(
              tooltip: 'Borrar del historial',
              onPressed: () => _confirmDeleteFromHistory(context, ref),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
        ],
      ),
      body: list.when(
        data: (list) {
          if (list == null) {
            return const Center(
              child: Text('Esta lista ya no está disponible.'),
            );
          }

          return items.when(
            data: (items) => categories.when(
              data: (categories) => _HistoryDetailBody(
                list: list,
                items: items,
                categories: categories,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Center(
                child: Text('No pudimos cargar las categorías.'),
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) =>
                const Center(child: Text('No pudimos cargar los items.')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('No pudimos cargar la lista.')),
      ),
    );
  }

  Future<void> _confirmDeleteFromHistory(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar del historial'),
        content: const Text('Se borrará esta compra del historial.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.tonalIcon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Borrar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    try {
      await ref.read(shoppingRepositoryProvider).deleteList(listId);
    } on StateError {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solo puedes borrar tus propias listas.'),
          ),
        );
      }
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lista borrada del historial.')),
      );
      context.go('/history');
    }
  }
}

class _HistoryDetailBody extends StatelessWidget {
  const _HistoryDetailBody({
    required this.list,
    required this.items,
    required this.categories,
  });

  final ShoppingList list;
  final List<ShoppingItem> items;
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final bought = items.where((item) => item.isChecked).toList();
    final pending = items.where((item) => !item.isChecked).toList();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final finishedAt = list.finishedAt ?? list.updatedAt;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title(list),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${list.type.label} · ${AppFormatters.historyDateTime(finishedAt)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricPill(
                          label: 'Comprados',
                          value: bought.length.toString(),
                          icon: Icons.check_circle_rounded,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MetricPill(
                          label: 'Pendientes',
                          value: pending.length.toString(),
                          icon: Icons.radio_button_unchecked_rounded,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total con precio',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        AppFormatters.money(list.total),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          _ItemSection(
            title: 'Comprado',
            emptyText: 'No hay items marcados como comprados.',
            items: bought,
            categories: categories,
            checked: true,
          ),
          const SizedBox(height: 18),
          _ItemSection(
            title: 'No comprado',
            emptyText: 'No quedaron items pendientes.',
            items: pending,
            categories: categories,
            checked: false,
          ),
        ],
      ),
    );
  }

  static String _title(ShoppingList list) {
    if (list.type.isSupermarket && list.storeName != null) {
      return '${list.storeName} · ${list.name}';
    }
    return list.name;
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.primary, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemSection extends StatelessWidget {
  const _ItemSection({
    required this.title,
    required this.emptyText,
    required this.items,
    required this.categories,
    required this.checked,
  });

  final String title;
  final String emptyText;
  final List<ShoppingItem> items;
  final List<CategoryEntity> categories;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textColor = checked ? colors.onSurface : colors.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                emptyText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          for (final item in items)
            _HistoryItemTile(
              item: item,
              categoryName: _categoryName(item.categoryId),
              checked: checked,
            ),
      ],
    );
  }

  String _categoryName(int categoryId) {
    for (final category in categories) {
      if (category.id == categoryId) {
        return category.name;
      }
    }
    return DefaultCategories.nameFor(categoryId);
  }
}

class _HistoryItemTile extends StatelessWidget {
  const _HistoryItemTile({
    required this.item,
    required this.categoryName,
    required this.checked,
  });

  final ShoppingItem item;
  final String categoryName;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              checked
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: checked ? colors.primary : colors.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: checked
                          ? colors.onSurface
                          : colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _meta,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              item.price == null
                  ? 'Sin precio'
                  : AppFormatters.money(item.price!),
              style: theme.textTheme.bodySmall?.copyWith(
                color: item.price == null ? colors.error : colors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _meta {
    return [
      if (item.quantity != null) item.quantity,
      if (item.brand != null) item.brand,
      categoryName,
    ].join(' · ');
  }
}
