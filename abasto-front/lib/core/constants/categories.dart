enum ItemCategory {
  frutas,
  verduras,
  carnes,
  lacteos,
  panaderia,
  bebidas,
  limpieza,
  higiene,
  congelados,
  snacks,
  otros,
}

extension ItemCategoryLabel on ItemCategory {
  String get label => switch (this) {
        ItemCategory.frutas => 'Frutas',
        ItemCategory.verduras => 'Verduras',
        ItemCategory.carnes => 'Carnes',
        ItemCategory.lacteos => 'Lácteos',
        ItemCategory.panaderia => 'Panadería',
        ItemCategory.bebidas => 'Bebidas',
        ItemCategory.limpieza => 'Limpieza',
        ItemCategory.higiene => 'Higiene',
        ItemCategory.congelados => 'Congelados',
        ItemCategory.snacks => 'Snacks',
        ItemCategory.otros => 'Otros',
      };
}
