import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/categories.dart';
import '../../../../core/constants/list_types.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/entities/shopping_item_draft.dart';
import '../../domain/entities/shopping_list.dart';
import '../providers/shopping_providers.dart';
import '../widgets/item_editor_sheet.dart';

class ShoppingPage extends ConsumerStatefulWidget {
  const ShoppingPage({super.key, required this.listId});

  final String listId;

  @override
  ConsumerState<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends ConsumerState<ShoppingPage> {
  final _quickAddController = TextEditingController();
  int? _quickCategoryId;
  bool _isFinishing = false;

  @override
  void dispose() {
    _quickAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(shoppingListProvider(widget.listId));
    final items = ref.watch(listItemsProvider(widget.listId));
    final categories = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: list.when(
        data: (list) {
          if (list == null) {
            return const _MissingListState();
          }

          return items.when(
            data: (items) => categories.when(
              data: (categories) {
                _quickCategoryId ??= categories.isEmpty
                    ? DefaultCategories.verduras.id
                    : categories.first.id;

                return _ShoppingContent(
                  list: list,
                  items: items,
                  categories: categories,
                  quickAddController: _quickAddController,
                  quickCategoryId: _quickCategoryId!,
                  isFinishing: _isFinishing,
                  onQuickCategoryChanged: (value) {
                    if (value != null) {
                      setState(() => _quickCategoryId = value);
                    }
                  },
                  onQuickAdd: () => _quickAdd(categories),
                  onAddDetailed: () => _addDetailed(categories),
                  onToggleItem: _toggleItem,
                  onEditItem: (item) => _editItem(item, categories),
                  onDeleteItem: _deleteItem,
                  onFinish: () => _finishList(list),
                  onDeleteList: () => _confirmDeleteList(list),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const _ShoppingError(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const _ShoppingError(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const _ShoppingError(),
      ),
    );
  }

  Future<void> _quickAdd(List<CategoryEntity> categories) async {
    final name = _quickAddController.text.trim();
    if (name.isEmpty) return;

    final categoryId =
        _quickCategoryId ?? (categories.isEmpty ? 1 : categories.first.id);
    await ref
        .read(shoppingRepositoryProvider)
        .addItem(
          listId: widget.listId,
          draft: ShoppingItemDraft(name: name, categoryId: categoryId),
        );
    _quickAddController.clear();
  }

  Future<void> _addDetailed(List<CategoryEntity> categories) async {
    final draft = await ItemEditorSheet.show(context, categories: categories);
    if (draft == null) return;

    await ref
        .read(shoppingRepositoryProvider)
        .addItem(listId: widget.listId, draft: draft);
  }

  Future<void> _toggleItem(ShoppingItem item) {
    return ref
        .read(shoppingRepositoryProvider)
        .toggleItem(id: item.id, isChecked: !item.isChecked);
  }

  Future<void> _editItem(
    ShoppingItem item,
    List<CategoryEntity> categories,
  ) async {
    final draft = await ItemEditorSheet.show(
      context,
      categories: categories,
      initialItem: item,
    );
    if (draft == null) return;

    await ref
        .read(shoppingRepositoryProvider)
        .updateItem(id: item.id, draft: draft);
  }

  Future<void> _deleteItem(ShoppingItem item) {
    return ref.read(shoppingRepositoryProvider).deleteItem(item.id);
  }

  Future<void> _finishList(ShoppingList list) async {
    if (_isFinishing) return;

    setState(() => _isFinishing = true);
    try {
      if (list.totalItems == 0) {
        if (!list.canDelete) {
          _showOwnershipMessage();
          return;
        }
        try {
          await ref.read(shoppingRepositoryProvider).deleteList(list.id);
        } on StateError {
          if (!mounted) return;
          _showOwnershipMessage();
          return;
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lista vacía descartada.')),
        );
        context.go('/lists');
        return;
      }

      await ref.read(shoppingRepositoryProvider).finishList(list.id);
      if (!mounted) return;
      context.go('/history');
    } finally {
      if (mounted) {
        setState(() => _isFinishing = false);
      }
    }
  }

  Future<void> _confirmDeleteList(ShoppingList list) async {
    if (!list.canDelete) {
      _showOwnershipMessage();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar lista'),
        content: Text(
          'Se borrará "${list.name}" y sus items de las listas pendientes.',
        ),
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
      await ref.read(shoppingRepositoryProvider).deleteList(list.id);
    } on StateError {
      if (!mounted) return;
      _showOwnershipMessage();
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Lista borrada.')));
    context.go('/lists');
  }

  void _showOwnershipMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solo puedes borrar tus propias listas.')),
    );
  }
}

class _ShoppingContent extends StatelessWidget {
  const _ShoppingContent({
    required this.list,
    required this.items,
    required this.categories,
    required this.quickAddController,
    required this.quickCategoryId,
    required this.isFinishing,
    required this.onQuickCategoryChanged,
    required this.onQuickAdd,
    required this.onAddDetailed,
    required this.onToggleItem,
    required this.onEditItem,
    required this.onDeleteItem,
    required this.onFinish,
    required this.onDeleteList,
  });

  final ShoppingList list;
  final List<ShoppingItem> items;
  final List<CategoryEntity> categories;
  final TextEditingController quickAddController;
  final int quickCategoryId;
  final bool isFinishing;
  final ValueChanged<int?> onQuickCategoryChanged;
  final VoidCallback onQuickAdd;
  final VoidCallback onAddDetailed;
  final ValueChanged<ShoppingItem> onToggleItem;
  final ValueChanged<ShoppingItem> onEditItem;
  final ValueChanged<ShoppingItem> onDeleteItem;
  final VoidCallback onFinish;
  final VoidCallback onDeleteList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final groupedItems = _groupItems(items, categories);

    return Column(
      children: [
        _ShoppingHeader(list: list, onDelete: onDeleteList),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _QuickAddRow(
                  controller: quickAddController,
                  categories: categories,
                  categoryId: quickCategoryId,
                  onCategoryChanged: onQuickCategoryChanged,
                  onSubmit: onQuickAdd,
                  onDetailed: onAddDetailed,
                ),
                const SizedBox(height: 16),
                if (items.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_basket_outlined,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Lista vacía. Agrega productos mientras compras.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  for (final group in groupedItems) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 12, 0, 8),
                      child: Text(
                        group.category.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colors.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    for (final item in group.items)
                      _ShoppingItemTile(
                        item: item,
                        categoryName: group.category.name,
                        onToggle: () => onToggleItem(item),
                        onEdit: () => onEditItem(item),
                        onDelete: () => onDeleteItem(item),
                      ),
                  ],
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(top: BorderSide(color: colors.outlineVariant)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FilledButton.icon(
                onPressed: isFinishing ? null : onFinish,
                icon: isFinishing
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.done_all_rounded),
                label: Text(isFinishing ? 'Finalizando...' : 'Finalizar lista'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static List<_CategoryGroup> _groupItems(
    List<ShoppingItem> items,
    List<CategoryEntity> categories,
  ) {
    final categoryById = {
      for (final category in categories) category.id: category,
    };
    final groups = <_CategoryGroup>[];

    for (final category in categories) {
      final categoryItems = items
          .where((item) => item.categoryId == category.id)
          .toList();
      if (categoryItems.isNotEmpty) {
        groups.add(_CategoryGroup(category, categoryItems));
      }
    }

    final uncategorized = items
        .where((item) => !categoryById.containsKey(item.categoryId))
        .toList();
    if (uncategorized.isNotEmpty) {
      groups.add(
        _CategoryGroup(
          const CategoryEntity(id: 0, name: 'Otros', order: 99),
          uncategorized,
        ),
      );
    }

    return groups;
  }
}

class _ShoppingHeader extends StatelessWidget {
  const _ShoppingHeader({required this.list, required this.onDelete});

  final ShoppingList list;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/lists');
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
                  label: const Text('Volver'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    foregroundColor: colors.primary,
                  ),
                ),
                const Spacer(),
                if (list.canDelete)
                  IconButton(
                    tooltip: 'Borrar lista',
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: colors.error,
                    ),
                  ),
              ],
            ),
            Text(
              _headerMeta(list),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onPrimaryContainer.withValues(alpha: 0.78),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    list.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 24,
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.onPrimaryContainer.withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),
                    Text(
                      AppFormatters.money(list.total),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onPrimaryContainer,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${list.pendingItems} pendientes · ${list.totalItems} en total',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onPrimaryContainer.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _headerMeta(ShoppingList list) {
    if (list.type.isSupermarket && list.storeName != null) {
      return '${list.type.label} · ${list.storeName}';
    }
    return list.type.label;
  }
}

class _QuickAddRow extends StatelessWidget {
  const _QuickAddRow({
    required this.controller,
    required this.categories,
    required this.categoryId,
    required this.onCategoryChanged,
    required this.onSubmit,
    required this.onDetailed,
  });

  final TextEditingController controller;
  final List<CategoryEntity> categories;
  final int categoryId;
  final ValueChanged<int?> onCategoryChanged;
  final VoidCallback onSubmit;
  final VoidCallback onDetailed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => onSubmit(),
                    decoration: const InputDecoration(
                      hintText: 'Agregar rápido',
                      prefixIcon: Icon(Icons.add_shopping_cart_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: 'Agregar item',
                  onPressed: onSubmit,
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: categoryId,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    items: [
                      for (final category in categories)
                        DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        ),
                    ],
                    onChanged: onCategoryChanged,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Agregar con precio, cantidad o marca',
                  onPressed: onDetailed,
                  icon: Icon(Icons.tune_rounded, color: colors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingItemTile extends StatelessWidget {
  const _ShoppingItemTile({
    required this.item,
    required this.categoryName,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final ShoppingItem item;
  final String categoryName;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final checked = item.isChecked;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: checked ? 0.55 : 1,
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
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
                          fontWeight: FontWeight.w700,
                          decoration: checked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _itemMeta(item, categoryName),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                item.price == null
                    ? const _MissingPriceBadge()
                    : Text(
                        AppFormatters.money(item.price!),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                      ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert_rounded),
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onEdit();
                      case 'delete':
                        onDelete();
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _itemMeta(ShoppingItem item, String categoryName) {
    return [
      if (item.quantity != null) item.quantity,
      if (item.brand != null) item.brand,
      categoryName,
    ].join(' · ');
  }
}

class _MissingPriceBadge extends StatefulWidget {
  const _MissingPriceBadge();

  @override
  State<_MissingPriceBadge> createState() => _MissingPriceBadgeState();
}

class _MissingPriceBadgeState extends State<_MissingPriceBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = theme.colorScheme.error;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = 0.85 + (_controller.value * 0.15);
        return Transform.scale(
          scale: pulse,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: error.withValues(alpha: 0.10 + _controller.value * 0.10),
              border: Border.all(color: error),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Falta precio',
              style: theme.textTheme.labelSmall?.copyWith(
                color: error,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryGroup {
  const _CategoryGroup(this.category, this.items);

  final CategoryEntity category;
  final List<ShoppingItem> items;
}

class _MissingListState extends StatelessWidget {
  const _MissingListState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista')),
      body: const Center(child: Text('Esta lista ya no está disponible.')),
    );
  }
}

class _ShoppingError extends StatelessWidget {
  const _ShoppingError();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No pudimos cargar la compra.'));
  }
}
