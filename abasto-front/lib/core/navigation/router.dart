import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/list_types.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/lists/presentation/pages/lists_page.dart';
import '../../features/lists/presentation/pages/create_list_page.dart';
import '../../features/lists/presentation/pages/shopping_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/history/presentation/pages/history_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/theme_settings_page.dart';
import 'shell_scaffold.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (_, _) => const NoTransitionPage(child: SplashPage()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (_, s) =>
            CupertinoPage(key: s.pageKey, child: const LoginPage()),
      ),
      ShellRoute(
        builder: (context, state, child) => ShellScaffold(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (_, _) => const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: '/lists',
            pageBuilder: (_, _) => const NoTransitionPage(child: ListsPage()),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (_, _) => const NoTransitionPage(child: HistoryPage()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (_, _) => const NoTransitionPage(child: ProfilePage()),
          ),
        ],
      ),
      GoRoute(
        path: '/lists/create',
        pageBuilder: (_, state) {
          final initialType = listTypeFromQuery(
            state.uri.queryParameters['type'],
          );
          return CupertinoPage(
            key: state.pageKey,
            child: CreateListPage(initialType: initialType),
          );
        },
      ),
      GoRoute(
        path: '/lists/:listId/shopping',
        pageBuilder: (_, state) {
          final listId = state.pathParameters['listId']!;
          return CupertinoPage(
            key: state.pageKey,
            child: ShoppingPage(listId: listId),
          );
        },
      ),
      GoRoute(
        path: '/history/:listId',
        pageBuilder: (_, state) {
          final listId = state.pathParameters['listId']!;
          return CupertinoPage(
            key: state.pageKey,
            child: HistoryDetailPage(listId: listId),
          );
        },
      ),
      GoRoute(
        path: '/profile/themes',
        pageBuilder: (_, state) =>
            CupertinoPage(key: state.pageKey, child: const ThemeSettingsPage()),
      ),
    ],
  );
}
