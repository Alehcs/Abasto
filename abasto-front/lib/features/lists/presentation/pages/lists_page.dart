import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/list_types.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/filter_pills.dart';
import '../../../../shared/widgets/list_card.dart';
import '../../domain/entities/shopping_list.dart';
import '../providers/shopping_providers.dart';

class ListsPage extends ConsumerStatefulWidget {
  const ListsPage({super.key});

  @override
  ConsumerState<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends ConsumerState<ListsPage> {
  int _filter = 0;
  static const _filters = ['Todas', 'Supermercado', 'Feria'];

  ListType? get _selectedType {
    return switch (_filter) {
      1 => ListType.supermercado,
      2 => ListType.feria,
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(activeListsProvider(type: _selectedType));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const AppHeader(title: 'Listas', subtitle: 'Activas y pendientes'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  FilterPills(
                    selected: _filter,
                    filters: _filters,
                    onSelect: (i) => setState(() => _filter = i),
                  ),
                  lists.when(
                    data: (items) {
                      if (items.isEmpty) {
                        return const _EmptyListsState();
                      }

                      return Column(
                        children: [
                          for (final list in items)
                            ListCard(
                              type: list.type.label,
                              title: _listTitle(list),
                              meta: AppFormatters.shortDateTime(list.updatedAt),
                              remaining:
                                  '${list.pendingItems} ${list.pendingItems == 1 ? 'item' : 'items'}',
                              icon: _iconFor(list.type),
                              onTap: () =>
                                  context.push('/lists/${list.id}/shopping'),
                              trailing: _ListActionsButton(
                                list: list,
                                onEdit: () => _showEditListDialog(list),
                                onDuplicate: () => _duplicateList(list),
                                onFinish: () => _finishList(list),
                                onDelete: () => _confirmDeleteList(list),
                              ),
                            ),
                          const SizedBox(height: 88),
                        ],
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(28),
                      child: CircularProgressIndicator(),
                    ),
                    error: (_, _) => const _ErrorState(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/lists/create'),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Future<void> _showEditListDialog(ShoppingList list) async {
    final nameController = TextEditingController(text: list.name);
    final storeController = TextEditingController(text: list.storeName ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar lista'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              if (list.type.isSupermarket) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: storeController,
                  decoration: const InputDecoration(
                    labelText: 'Supermercado opcional',
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await ref
          .read(shoppingRepositoryProvider)
          .updateList(
            id: list.id,
            name: nameController.text,
            storeName: storeController.text,
          );
    }

    nameController.dispose();
    storeController.dispose();
  }

  Future<void> _duplicateList(ShoppingList list) async {
    final newListId = await ref
        .read(shoppingRepositoryProvider)
        .duplicateList(list.id);
    if (!mounted) return;
    context.push('/lists/$newListId/shopping');
  }

  Future<void> _finishList(ShoppingList list) async {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Lista vacía descartada.')));
      return;
    }

    await ref.read(shoppingRepositoryProvider).finishList(list.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lista finalizada y enviada al historial.')),
    );
  }

  Future<void> _confirmDeleteList(ShoppingList list) async {
    if (!list.canDelete) {
      _showOwnershipMessage();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar lista'),
        content: Text('Se eliminará "${list.name}" de este dispositivo.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(shoppingRepositoryProvider).deleteList(list.id);
      } on StateError {
        if (!mounted) return;
        _showOwnershipMessage();
      }
    }
  }

  void _showOwnershipMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solo puedes borrar tus propias listas.')),
    );
  }

  static String _listTitle(ShoppingList list) {
    if (list.type.isSupermarket && list.storeName != null) {
      return '${list.storeName} · ${list.name}';
    }
    return list.name;
  }

  static IconData _iconFor(ListType type) {
    return type.isSupermarket
        ? Icons.local_grocery_store_outlined
        : Icons.eco_outlined;
  }
}

class _ListActionsButton extends StatelessWidget {
  const _ListActionsButton({
    required this.list,
    required this.onEdit,
    required this.onDuplicate,
    required this.onFinish,
    required this.onDelete,
  });

  final ShoppingList list;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onFinish;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit();
          case 'duplicate':
            onDuplicate();
          case 'finish':
            onFinish();
          case 'delete':
            onDelete?.call();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'edit', child: Text('Editar')),
        const PopupMenuItem(value: 'duplicate', child: Text('Duplicar')),
        const PopupMenuItem(value: 'finish', child: Text('Finalizar')),
        if (list.canDelete)
          const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
      ],
    );
  }
}

class _EmptyListsState extends StatelessWidget {
  const _EmptyListsState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.playlist_add_rounded, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No hay listas activas. Crea una para supermercado o feria.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      'No pudimos cargar las listas.',
      style: TextStyle(color: colors.error),
    );
  }
}
