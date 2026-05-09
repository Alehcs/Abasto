import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/list_types.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../features/lists/domain/entities/shopping_list.dart';
import '../../../../features/lists/presentation/providers/shopping_providers.dart';
import '../../../../core/theme/theme_preset.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/filter_pills.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
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
    final history = ref.watch(finishedListsProvider(type: _selectedType));
    final theme = Theme.of(context);
    final isHawaii = theme.extension<AppThemeDecoration>()?.isHawaii ?? false;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          AppHeader(
            title: 'Historial',
            subtitle: 'Compras anteriores',
            trailing: isHawaii
                ? _HawaiiClearButton(onTap: _confirmClearHistory)
                : IconButton(
                    tooltip: 'Limpiar historial',
                    onPressed: _confirmClearHistory,
                    icon: Icon(
                      Icons.cleaning_services_outlined,
                      color: theme.colorScheme.primary,
                    ),
                  ),
          ),
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
                  history.when(
                    data: (lists) {
                      if (lists.isEmpty) {
                        return const _EmptyHistoryState();
                      }

                      return Column(
                        children: [
                          for (final list in lists)
                            _HistoryCard(
                              list: list,
                              onOpen: () => context.push('/history/${list.id}'),
                              onDuplicate: () => _duplicateList(list),
                              onDelete: () => _deleteHistoryList(list),
                            ),
                        ],
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(28),
                      child: CircularProgressIndicator(),
                    ),
                    error: (_, _) => const _HistoryError(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _duplicateList(ShoppingList list) async {
    final newListId = await ref
        .read(shoppingRepositoryProvider)
        .duplicateList(list.id);
    if (!mounted) return;
    context.push('/lists/$newListId/shopping');
  }

  Future<void> _deleteHistoryList(ShoppingList list) async {
    if (!list.canDelete) {
      _showOwnershipMessage();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar del historial'),
        content: Text('Se borrará "${list.name}" del historial.'),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lista borrada del historial.')),
    );
  }

  void _showOwnershipMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solo puedes borrar tus propias listas.')),
    );
  }

  Future<void> _confirmClearHistory() async {
    final scope = _historyScopeLabel(_selectedType);
    final firstConfirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpiar $scope'),
        content: Text(
          _selectedType == null
              ? 'Esto borrará TODO el historial de compras finalizadas propias.'
              : 'Esto borrará solo las compras finalizadas propias de $scope.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );

    if (firstConfirmation != true || !mounted) return;

    final secondConfirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar limpieza'),
        content: Text(
          _selectedType == null
              ? 'Última confirmación: se borrará TODO tu historial en este dispositivo.'
              : 'Última confirmación: se borrará el historial de $scope en este dispositivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.delete_sweep_outlined),
            label: Text('Limpiar $scope'),
          ),
        ],
      ),
    );

    if (secondConfirmation != true) return;
    await ref
        .read(shoppingRepositoryProvider)
        .clearHistory(type: _selectedType);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$scope limpiado.')));
  }

  static String _historyScopeLabel(ListType? type) {
    return switch (type) {
      ListType.supermercado => 'historial de supermercado',
      ListType.feria => 'historial de feria',
      null => 'historial',
    };
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.list,
    required this.onOpen,
    required this.onDuplicate,
    required this.onDelete,
  });

  final ShoppingList list;
  final VoidCallback onOpen;
  final VoidCallback onDuplicate;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final finishedAt = list.finishedAt ?? list.updatedAt;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      list.type.isSupermarket
                          ? Icons.local_grocery_store_outlined
                          : Icons.eco_outlined,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list.type.label,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _title(list),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppFormatters.historyDateTime(finishedAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded),
                    onSelected: (value) {
                      switch (value) {
                        case 'duplicate':
                          onDuplicate();
                        case 'delete':
                          onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: Text('Duplicar'),
                      ),
                      if (list.canDelete)
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Borrar del historial'),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    AppFormatters.money(list.total),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (list.pendingItems > 0) ...[
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${list.pendingItems} no comprado${list.pendingItems == 1 ? '' : 's'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    list.pendingItemNames.take(4).join(' · '),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant.withValues(alpha: 0.68),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
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

class _EmptyHistoryState extends StatelessWidget {
  const _EmptyHistoryState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.history_rounded, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Las listas finalizadas aparecerán aquí.',
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

class _HistoryError extends StatelessWidget {
  const _HistoryError();

  @override
  Widget build(BuildContext context) {
    return const Text('No pudimos cargar el historial.');
  }
}

class _HawaiiClearButton extends StatelessWidget {
  const _HawaiiClearButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
            center: Alignment(-0.3, -0.3),
          ),
          border: Border.all(color: const Color(0xFF7A4A2D), width: 2),
          boxShadow: const [
            BoxShadow(color: Color(0x40000000), blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
        child: const Icon(
          Icons.cleaning_services_outlined,
          color: Color(0xFFFFF0D0),
          size: 20,
        ),
      ),
    );
  }
}
