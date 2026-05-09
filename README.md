# Abasto

App móvil de listas de compra familiar para iOS y Android.

Separación estricta entre **supermercado** y **feria**, diseñada para uso rápido durante la compra real.

---

## Estructura del repo

```
abasto/
├── abasto-front/   # Flutter app (iOS + Android)
└── abasto-back/    # Reservado para Fase 2 (Firebase)
```

---

## Stack tecnológico

| Capa | Tecnología |
|------|------------|
| Framework | Flutter + Dart |
| Base de datos local | SQLite via Drift |
| Estado | Riverpod |
| Navegación | go_router |
| Modelos | Freezed |
| Backend (Fase 2) | Firebase Auth + Firestore |

---

## Arquitectura

Arquitectura por **features** con separación por capas:

```
lib/
├── core/
│   ├── database/       # Configuración Drift + migraciones
│   ├── theme/          # Colores, tipografía, tema claro/oscuro
│   ├── navigation/     # go_router + ShellScaffold con bottom nav
│   ├── constants/      # Categorías, tipos de lista
│   └── services/       # Sincronización futura
├── features/
│   ├── home/           # Pantalla principal + accesos rápidos
│   ├── lists/          # Gestión de listas activas
│   ├── history/        # Listas finalizadas
│   └── profile/        # Configuración + tema
└── shared/
    └── widgets/        # Componentes reutilizables
```

Cada feature sigue la estructura:

```
feature/
├── data/
│   ├── datasources/    # SQLite (local), Firebase (Fase 2)
│   ├── models/         # DTOs
│   └── repositories/   # Implementación de acceso a datos
├── domain/
│   ├── entities/       # Entidades de negocio
│   ├── repositories/   # Interfaces abstractas
│   └── usecases/       # Lógica de negocio
└── presentation/
    ├── pages/          # Pantallas completas
    ├── widgets/        # Componentes del feature
    └── providers/      # Estado con Riverpod
```

---

## Funcionalidades

### Fase 1 — Local (offline-first)
- Crear listas de tipo **Supermercado** o **Feria**
- Agregar ítems con nombre, cantidad, precio, categoría y marca
- Agrupación automática por categoría con orden fijo
- Marcar ítems con un toque durante la compra
- Total automático en tiempo real
- Historial de listas finalizadas con opción de duplicar
- Recomendaciones basadas en uso frecuente
- Tema claro / oscuro
- Funciona 100% sin conexión

### Fase 2 — Sincronización (pendiente)
- Autenticación con Firebase Auth
- Listas compartidas con edición colaborativa
- Sincronización en segundo plano con Firestore

---

## Correr el proyecto

### Requisitos
- Flutter SDK ≥ 3.11
- Dart ≥ 3.11

### Instalación

```bash
cd abasto-front
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Navegación

La app tiene 4 secciones accesibles desde la barra inferior:

| Tab | Descripción |
|-----|-------------|
| Inicio | Listas activas + acceso rápido a crear nueva lista |
| Listas | Vista y gestión de todas las listas activas |
| Historial | Listas finalizadas, detalle y duplicación |
| Perfil | Nombre de usuario, tema claro/oscuro |

---

## Principios UX

- Máximo 1–2 taps por acción importante
- Feedback visual inmediato al marcar ítems
- Optimizado para uso con una mano
- Minimalista, enfocado en legibilidad
