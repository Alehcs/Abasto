enum ListType { supermercado, feria }

extension ListTypeLabel on ListType {
  String get label => switch (this) {
        ListType.supermercado => 'Supermercado',
        ListType.feria => 'Feria',
      };
}
