class DefaultCategory {
  const DefaultCategory({
    required this.id,
    required this.name,
    required this.order,
  });

  final int id;
  final String name;
  final int order;
}

abstract final class DefaultCategories {
  static const verduras = DefaultCategory(id: 1, name: 'Verduras', order: 1);
  static const frutas = DefaultCategory(id: 2, name: 'Frutas', order: 2);
  static const carnes = DefaultCategory(id: 3, name: 'Carnes', order: 3);
  static const lacteos = DefaultCategory(id: 4, name: 'Lácteos', order: 4);
  static const bebidas = DefaultCategory(id: 5, name: 'Bebidas', order: 13);
  static const snacks = DefaultCategory(id: 6, name: 'Snacks', order: 14);
  static const aseo = DefaultCategory(id: 7, name: 'Aseo', order: 18);
  static const pescadosMariscos = DefaultCategory(
    id: 8,
    name: 'Pescados y mariscos',
    order: 4,
  );
  static const huevos = DefaultCategory(id: 9, name: 'Huevos', order: 6);
  static const panaderia = DefaultCategory(id: 10, name: 'Panadería', order: 7);
  static const pastasArroz = DefaultCategory(
    id: 11,
    name: 'Pastas y arroz',
    order: 8,
  );
  static const legumbres = DefaultCategory(id: 12, name: 'Legumbres', order: 9);
  static const despensa = DefaultCategory(id: 13, name: 'Despensa', order: 10);
  static const azucarReposteria = DefaultCategory(
    id: 14,
    name: 'Azúcar y repostería',
    order: 11,
  );
  static const condimentos = DefaultCategory(
    id: 15,
    name: 'Condimentos',
    order: 12,
  );
  static const conservas = DefaultCategory(
    id: 16,
    name: 'Conservas',
    order: 15,
  );
  static const congelados = DefaultCategory(
    id: 17,
    name: 'Congelados',
    order: 16,
  );
  static const dulces = DefaultCategory(id: 18, name: 'Dulces', order: 17);
  static const cuidadoPersonal = DefaultCategory(
    id: 19,
    name: 'Cuidado personal',
    order: 19,
  );
  static const hogar = DefaultCategory(id: 20, name: 'Hogar', order: 20);
  static const mascotas = DefaultCategory(id: 21, name: 'Mascotas', order: 21);
  static const bebe = DefaultCategory(id: 22, name: 'Bebé', order: 22);
  static const farmacia = DefaultCategory(id: 23, name: 'Farmacia', order: 23);
  static const frutosSecos = DefaultCategory(
    id: 24,
    name: 'Frutos secos',
    order: 24,
  );
  static const hierbas = DefaultCategory(id: 25, name: 'Hierbas', order: 25);
  static const otros = DefaultCategory(id: 26, name: 'Otros', order: 99);

  static const values = [
    verduras,
    frutas,
    carnes,
    pescadosMariscos,
    lacteos,
    huevos,
    panaderia,
    pastasArroz,
    legumbres,
    despensa,
    azucarReposteria,
    condimentos,
    bebidas,
    snacks,
    conservas,
    congelados,
    dulces,
    aseo,
    cuidadoPersonal,
    hogar,
    mascotas,
    bebe,
    farmacia,
    frutosSecos,
    hierbas,
    otros,
  ];

  static String nameFor(int id) {
    return values
        .firstWhere((category) => category.id == id, orElse: () => otros)
        .name;
  }
}
