import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/categories.dart';
import '../../../../core/constants/list_types.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/shopping_item_draft.dart';
import '../providers/shopping_providers.dart';
import '../widgets/item_editor_sheet.dart';

class CreateListPage extends ConsumerStatefulWidget {
  const CreateListPage({super.key, this.initialType});

  final ListType? initialType;

  @override
  ConsumerState<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends ConsumerState<CreateListPage> {
  late ListType _type;
  final _nameController = TextEditingController();
  final _storeController = TextEditingController();
  final List<ShoppingItemDraft> _draftItems = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType ?? ListType.supermercado;
    _nameController.text = _type.defaultName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _storeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Crear lista'), centerTitle: false),
      body: categories.when(
        data: (items) => _CreateListBody(
          type: _type,
          nameController: _nameController,
          storeController: _storeController,
          draftItems: _draftItems,
          categories: items,
          isSaving: _isSaving,
          onTypeChanged: _setType,
          onAddItem: () => _addItem(items),
          onEditItem: (index) => _editItem(index, items),
          onDeleteItem: _deleteItem,
          onCreate: _createList,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) =>
            const Center(child: Text('No pudimos cargar las categorías.')),
      ),
    );
  }

  void _setType(ListType type) {
    setState(() {
      _type = type;
      if (_nameController.text.trim().isEmpty ||
          ListType.values
              .map((type) => type.defaultName)
              .contains(_nameController.text.trim())) {
        _nameController.text = type.defaultName;
      }
      if (!type.isSupermarket) {
        _storeController.clear();
      }
    });
  }

  Future<void> _addItem(List<CategoryEntity> categories) async {
    final draft = await ItemEditorSheet.show(context, categories: categories);
    if (draft == null) return;
    setState(() => _draftItems.add(draft));
  }

  Future<void> _editItem(int index, List<CategoryEntity> categories) async {
    final draft = await ItemEditorSheet.show(
      context,
      categories: categories,
      initialDraft: _draftItems[index],
    );
    if (draft == null) return;
    setState(() => _draftItems[index] = draft);
  }

  void _deleteItem(int index) {
    setState(() => _draftItems.removeAt(index));
  }

  Future<void> _createList() async {
    if (_isSaving) return;

    setState(() => _isSaving = true);
    try {
      final list = await ref
          .read(shoppingRepositoryProvider)
          .createList(
            type: _type,
            name: _nameController.text,
            storeName: _storeController.text,
            items: _draftItems,
          );
      if (!mounted) return;
      context.go('/lists/${list.id}/shopping');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}

class _CreateListBody extends StatelessWidget {
  const _CreateListBody({
    required this.type,
    required this.nameController,
    required this.storeController,
    required this.draftItems,
    required this.categories,
    required this.isSaving,
    required this.onTypeChanged,
    required this.onAddItem,
    required this.onEditItem,
    required this.onDeleteItem,
    required this.onCreate,
  });

  final ListType type;
  final TextEditingController nameController;
  final TextEditingController storeController;
  final List<ShoppingItemDraft> draftItems;
  final List<CategoryEntity> categories;
  final bool isSaving;
  final ValueChanged<ListType> onTypeChanged;
  final VoidCallback onAddItem;
  final ValueChanged<int> onEditItem;
  final ValueChanged<int> onDeleteItem;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Tipo de compra'),
          Row(
            children: [
              Expanded(
                child: _TypeCard(
                  icon: Icons.local_grocery_store_outlined,
                  label: 'Supermercado',
                  selected: type == ListType.supermercado,
                  onTap: () => onTypeChanged(ListType.supermercado),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TypeCard(
                  icon: Icons.eco_outlined,
                  label: 'Feria',
                  selected: type == ListType.feria,
                  onTap: () => onTypeChanged(ListType.feria),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SectionTitle(title: 'Datos de lista'),
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Nombre de lista'),
          ),
          if (type.isSupermarket) ...[
            const SizedBox(height: 12),
            TextField(
              controller: storeController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Supermercado opcional',
              ),
            ),
          ],
          const SizedBox(height: 24),
          SectionTitle(
            title: 'Items iniciales',
            action: 'Agregar',
            onAction: onAddItem,
          ),
          if (draftItems.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Puedes partir vacía o agregar productos ahora.',
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
            for (var i = 0; i < draftItems.length; i++)
              _DraftItemTile(
                draft: draftItems[i],
                categoryName: _categoryName(
                  categories,
                  draftItems[i].categoryId,
                ),
                onTap: () => onEditItem(i),
                onDelete: () => onDeleteItem(i),
              ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: isSaving ? null : onCreate,
            icon: isSaving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_forward_rounded),
            label: Text(isSaving ? 'Creando...' : 'Crear y comprar'),
          ),
        ],
      ),
    );
  }

  static String _categoryName(List<CategoryEntity> categories, int id) {
    for (final category in categories) {
      if (category.id == id) return category.name;
    }
    return DefaultCategories.nameFor(id);
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      color: selected ? colors.primary : colors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: selected ? colors.onPrimary : colors.primary,
                size: 26,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: selected ? colors.onPrimary : colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DraftItemTile extends StatelessWidget {
  const _DraftItemTile({
    required this.draft,
    required this.categoryName,
    required this.onTap,
    required this.onDelete,
  });

  final ShoppingItemDraft draft;
  final String categoryName;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(Icons.shopping_basket_outlined, color: colors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      draft.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      [
                        if (draft.quantity != null) draft.quantity,
                        categoryName,
                      ].join(' · '),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Eliminar item',
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
