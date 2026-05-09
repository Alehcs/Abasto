import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/entities/shopping_item_draft.dart';

class ItemEditorSheet extends StatefulWidget {
  const ItemEditorSheet({
    super.key,
    required this.categories,
    this.initialItem,
    this.initialDraft,
  });

  final List<CategoryEntity> categories;
  final ShoppingItem? initialItem;
  final ShoppingItemDraft? initialDraft;

  static Future<ShoppingItemDraft?> show(
    BuildContext context, {
    required List<CategoryEntity> categories,
    ShoppingItem? initialItem,
    ShoppingItemDraft? initialDraft,
  }) {
    return showModalBottomSheet<ShoppingItemDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ItemEditorSheet(
          categories: categories,
          initialItem: initialItem,
          initialDraft: initialDraft,
        );
      },
    );
  }

  @override
  State<ItemEditorSheet> createState() => _ItemEditorSheetState();
}

class _ItemEditorSheetState extends State<ItemEditorSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;
  late final TextEditingController _brandController;
  late int _categoryId;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialDraft;
    final item = widget.initialItem;
    _nameController = TextEditingController(text: item?.name ?? initial?.name);
    _quantityController = TextEditingController(
      text: item?.quantity ?? initial?.quantity,
    );
    _priceController = TextEditingController(
      text: _initialPriceText(item?.price ?? initial?.price),
    );
    _brandController = TextEditingController(
      text: item?.brand ?? initial?.brand,
    );
    _categoryId =
        item?.categoryId ??
        initial?.categoryId ??
        (widget.categories.isEmpty ? 1 : widget.categories.first.id);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.initialItem == null ? 'Agregar item' : 'Editar item',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            autofocus: widget.initialItem == null,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Precio'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: _categoryId,
            decoration: const InputDecoration(labelText: 'Categoría'),
            items: [
              for (final category in widget.categories)
                DropdownMenuItem(
                  value: category.id,
                  child: Text(category.name),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _categoryId = value);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brandController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Marca opcional'),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: _submit,
            child: Text(widget.initialItem == null ? 'Agregar' : 'Guardar'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    Navigator.of(context).pop(
      ShoppingItemDraft(
        name: name,
        quantity: _emptyToNull(_quantityController.text),
        price: _parsePrice(_priceController.text),
        categoryId: _categoryId,
        brand: _emptyToNull(_brandController.text),
      ),
    );
  }

  static String _initialPriceText(double? price) {
    if (price == null) return '';
    return price.round().toString();
  }

  static double? _parsePrice(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;

    final cleaned = trimmed.replaceAll(RegExp(r'[^0-9,.]'), '');
    if (cleaned.isEmpty) return null;

    final normalized = cleaned.contains(',')
        ? cleaned.replaceAll('.', '').replaceAll(',', '.')
        : cleaned.replaceAll('.', '');

    return double.tryParse(normalized);
  }

  static String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
