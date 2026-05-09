enum ListType { supermercado, feria }

extension ListTypeLabel on ListType {
  String get label => switch (this) {
    ListType.supermercado => 'Supermercado',
    ListType.feria => 'Feria',
  };

  String get defaultName => switch (this) {
    ListType.supermercado => 'Lista supermercado',
    ListType.feria => 'Lista feria',
  };

  bool get isSupermarket => this == ListType.supermercado;
}

extension ListTypeParser on ListType {
  static ListType fromDatabase(String value) {
    return ListType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ListType.supermercado,
    );
  }
}

ListType? listTypeFromQuery(String? value) {
  if (value == null) return null;
  for (final type in ListType.values) {
    if (type.name == value) {
      return type;
    }
  }
  return null;
}
