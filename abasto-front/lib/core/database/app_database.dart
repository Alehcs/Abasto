import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/categories.dart';
import '../services/sync_status.dart';

part 'app_database.g.dart';

@DataClassName('ShoppingListRow')
class ShoppingLists extends Table {
  @override
  String get tableName => 'lists';

  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get storeName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  BoolColumn get isShared => boolean().withDefault(const Constant(false))();
  TextColumn get ownerId => text().nullable()();
  TextColumn get sharedWith => text().withDefault(const Constant('[]'))();
  TextColumn get syncStatus =>
      text().withDefault(Constant(SyncStatus.local.name))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ShoppingItemRow')
class ShoppingItems extends Table {
  @override
  String get tableName => 'items';

  TextColumn get id => text()();
  TextColumn get listId => text().references(ShoppingLists, #id)();
  TextColumn get name => text()();
  TextColumn get quantity => text().nullable()();
  RealColumn get price => real().nullable()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get brand => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus =>
      text().withDefault(Constant(SyncStatus.local.name))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CategoryRow')
class Categories extends Table {
  @override
  String get tableName => 'categories';

  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get order => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AppPreferenceRow')
class AppPreferences extends Table {
  @override
  String get tableName => 'app_preferences';

  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [ShoppingLists, ShoppingItems, Categories, AppPreferences],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(appPreferences);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        await _seedCategories();
      },
    );
  }

  Future<void> _seedCategories() async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        categories,
        DefaultCategories.values.map((category) {
          return CategoriesCompanion.insert(
            id: Value(category.id),
            name: category.name,
            order: category.order,
          );
        }).toList(),
      );
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'abasto.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
