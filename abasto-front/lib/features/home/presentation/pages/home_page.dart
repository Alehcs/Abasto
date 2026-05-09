import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/list_types.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../features/lists/domain/entities/shopping_list.dart';
import '../../../../features/lists/presentation/providers/shopping_providers.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../shared/widgets/list_card.dart';
import '../../../../shared/widgets/section_title.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentLists = ref.watch(activeListsProvider(limit: 3));
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const AppHeader(title: 'Tus compras', subtitle: 'Hola, Alejandro'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(title: 'Crear rápido'),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickCard(
                          icon: Icons.local_grocery_store_outlined,
                          title: 'Supermercado',
                          onTap: () => context.push(
                            '/lists/create?type=${ListType.supermercado.name}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _QuickCard(
                          icon: Icons.eco_outlined,
                          title: 'Feria',
                          onTap: () => context.push(
                            '/lists/create?type=${ListType.feria.name}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SectionTitle(
                    title: 'Listas activas',
                    action: 'Ver todas',
                    onAction: () => context.go('/lists'),
                  ),
                  recentLists.when(
                    data: (lists) {
                      if (lists.isEmpty) {
                        return _EmptyHomeState(colors: colors, theme: theme);
                      }

                      return Column(
                        children: [
                          for (final list in lists)
                            ListCard(
                              type: list.type.label,
                              title: _listTitle(list),
                              meta: AppFormatters.shortDateTime(list.updatedAt),
                              remaining:
                                  '${list.pendingItems} ${list.pendingItems == 1 ? 'item' : 'items'}',
                              icon: _iconFor(list.type),
                              onTap: () =>
                                  context.push('/lists/${list.id}/shopping'),
                            ),
                        ],
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (_, _) => Text(
                      'No pudimos cargar tus listas.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: colors.primary, size: 26),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Nueva lista',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyHomeState extends StatelessWidget {
  const _EmptyHomeState({required this.colors, required this.theme});

  final ColorScheme colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.playlist_add_rounded, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Crea tu primera lista y quedará disponible sin internet.',
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
