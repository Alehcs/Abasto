// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shoppingRepositoryHash() =>
    r'8eab79d8644506e6f6830ca4af5df12527d4754d';

/// See also [shoppingRepository].
@ProviderFor(shoppingRepository)
final shoppingRepositoryProvider =
    AutoDisposeProvider<ShoppingRepository>.internal(
      shoppingRepository,
      name: r'shoppingRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$shoppingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShoppingRepositoryRef = AutoDisposeProviderRef<ShoppingRepository>;
String _$categoriesHash() => r'f30c9880de38e21b64dfc195bd41c6e4989095a6';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider =
    AutoDisposeStreamProvider<List<CategoryEntity>>.internal(
      categories,
      name: r'categoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeStreamProviderRef<List<CategoryEntity>>;
String _$activeListsHash() => r'4e62cbd64f1e3b78d78fa6e1623b350b2719fa75';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [activeLists].
@ProviderFor(activeLists)
const activeListsProvider = ActiveListsFamily();

/// See also [activeLists].
class ActiveListsFamily extends Family<AsyncValue<List<ShoppingList>>> {
  /// See also [activeLists].
  const ActiveListsFamily();

  /// See also [activeLists].
  ActiveListsProvider call({ListType? type, int? limit}) {
    return ActiveListsProvider(type: type, limit: limit);
  }

  @override
  ActiveListsProvider getProviderOverride(
    covariant ActiveListsProvider provider,
  ) {
    return call(type: provider.type, limit: provider.limit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activeListsProvider';
}

/// See also [activeLists].
class ActiveListsProvider
    extends AutoDisposeStreamProvider<List<ShoppingList>> {
  /// See also [activeLists].
  ActiveListsProvider({ListType? type, int? limit})
    : this._internal(
        (ref) => activeLists(ref as ActiveListsRef, type: type, limit: limit),
        from: activeListsProvider,
        name: r'activeListsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$activeListsHash,
        dependencies: ActiveListsFamily._dependencies,
        allTransitiveDependencies: ActiveListsFamily._allTransitiveDependencies,
        type: type,
        limit: limit,
      );

  ActiveListsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.limit,
  }) : super.internal();

  final ListType? type;
  final int? limit;

  @override
  Override overrideWith(
    Stream<List<ShoppingList>> Function(ActiveListsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActiveListsProvider._internal(
        (ref) => create(ref as ActiveListsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ShoppingList>> createElement() {
    return _ActiveListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveListsProvider &&
        other.type == type &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActiveListsRef on AutoDisposeStreamProviderRef<List<ShoppingList>> {
  /// The parameter `type` of this provider.
  ListType? get type;

  /// The parameter `limit` of this provider.
  int? get limit;
}

class _ActiveListsProviderElement
    extends AutoDisposeStreamProviderElement<List<ShoppingList>>
    with ActiveListsRef {
  _ActiveListsProviderElement(super.provider);

  @override
  ListType? get type => (origin as ActiveListsProvider).type;
  @override
  int? get limit => (origin as ActiveListsProvider).limit;
}

String _$finishedListsHash() => r'f24ea93775a6f7a9b9f26655dab9aaba1c6b04df';

/// See also [finishedLists].
@ProviderFor(finishedLists)
const finishedListsProvider = FinishedListsFamily();

/// See also [finishedLists].
class FinishedListsFamily extends Family<AsyncValue<List<ShoppingList>>> {
  /// See also [finishedLists].
  const FinishedListsFamily();

  /// See also [finishedLists].
  FinishedListsProvider call({ListType? type}) {
    return FinishedListsProvider(type: type);
  }

  @override
  FinishedListsProvider getProviderOverride(
    covariant FinishedListsProvider provider,
  ) {
    return call(type: provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'finishedListsProvider';
}

/// See also [finishedLists].
class FinishedListsProvider
    extends AutoDisposeStreamProvider<List<ShoppingList>> {
  /// See also [finishedLists].
  FinishedListsProvider({ListType? type})
    : this._internal(
        (ref) => finishedLists(ref as FinishedListsRef, type: type),
        from: finishedListsProvider,
        name: r'finishedListsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$finishedListsHash,
        dependencies: FinishedListsFamily._dependencies,
        allTransitiveDependencies:
            FinishedListsFamily._allTransitiveDependencies,
        type: type,
      );

  FinishedListsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final ListType? type;

  @override
  Override overrideWith(
    Stream<List<ShoppingList>> Function(FinishedListsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FinishedListsProvider._internal(
        (ref) => create(ref as FinishedListsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ShoppingList>> createElement() {
    return _FinishedListsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinishedListsProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FinishedListsRef on AutoDisposeStreamProviderRef<List<ShoppingList>> {
  /// The parameter `type` of this provider.
  ListType? get type;
}

class _FinishedListsProviderElement
    extends AutoDisposeStreamProviderElement<List<ShoppingList>>
    with FinishedListsRef {
  _FinishedListsProviderElement(super.provider);

  @override
  ListType? get type => (origin as FinishedListsProvider).type;
}

String _$shoppingListHash() => r'7373e566bb130912dbc7886775a45eaa2ecd2f25';

/// See also [shoppingList].
@ProviderFor(shoppingList)
const shoppingListProvider = ShoppingListFamily();

/// See also [shoppingList].
class ShoppingListFamily extends Family<AsyncValue<ShoppingList?>> {
  /// See also [shoppingList].
  const ShoppingListFamily();

  /// See also [shoppingList].
  ShoppingListProvider call(String id) {
    return ShoppingListProvider(id);
  }

  @override
  ShoppingListProvider getProviderOverride(
    covariant ShoppingListProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'shoppingListProvider';
}

/// See also [shoppingList].
class ShoppingListProvider extends AutoDisposeStreamProvider<ShoppingList?> {
  /// See also [shoppingList].
  ShoppingListProvider(String id)
    : this._internal(
        (ref) => shoppingList(ref as ShoppingListRef, id),
        from: shoppingListProvider,
        name: r'shoppingListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$shoppingListHash,
        dependencies: ShoppingListFamily._dependencies,
        allTransitiveDependencies:
            ShoppingListFamily._allTransitiveDependencies,
        id: id,
      );

  ShoppingListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<ShoppingList?> Function(ShoppingListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShoppingListProvider._internal(
        (ref) => create(ref as ShoppingListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ShoppingList?> createElement() {
    return _ShoppingListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShoppingListProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShoppingListRef on AutoDisposeStreamProviderRef<ShoppingList?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ShoppingListProviderElement
    extends AutoDisposeStreamProviderElement<ShoppingList?>
    with ShoppingListRef {
  _ShoppingListProviderElement(super.provider);

  @override
  String get id => (origin as ShoppingListProvider).id;
}

String _$listItemsHash() => r'7ec526f4f19dd92efa1d86a36b080550a677558b';

/// See also [listItems].
@ProviderFor(listItems)
const listItemsProvider = ListItemsFamily();

/// See also [listItems].
class ListItemsFamily extends Family<AsyncValue<List<ShoppingItem>>> {
  /// See also [listItems].
  const ListItemsFamily();

  /// See also [listItems].
  ListItemsProvider call(String listId) {
    return ListItemsProvider(listId);
  }

  @override
  ListItemsProvider getProviderOverride(covariant ListItemsProvider provider) {
    return call(provider.listId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listItemsProvider';
}

/// See also [listItems].
class ListItemsProvider extends AutoDisposeStreamProvider<List<ShoppingItem>> {
  /// See also [listItems].
  ListItemsProvider(String listId)
    : this._internal(
        (ref) => listItems(ref as ListItemsRef, listId),
        from: listItemsProvider,
        name: r'listItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listItemsHash,
        dependencies: ListItemsFamily._dependencies,
        allTransitiveDependencies: ListItemsFamily._allTransitiveDependencies,
        listId: listId,
      );

  ListItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.listId,
  }) : super.internal();

  final String listId;

  @override
  Override overrideWith(
    Stream<List<ShoppingItem>> Function(ListItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListItemsProvider._internal(
        (ref) => create(ref as ListItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        listId: listId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<ShoppingItem>> createElement() {
    return _ListItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListItemsProvider && other.listId == listId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, listId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListItemsRef on AutoDisposeStreamProviderRef<List<ShoppingItem>> {
  /// The parameter `listId` of this provider.
  String get listId;
}

class _ListItemsProviderElement
    extends AutoDisposeStreamProviderElement<List<ShoppingItem>>
    with ListItemsRef {
  _ListItemsProviderElement(super.provider);

  @override
  String get listId => (origin as ListItemsProvider).listId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
