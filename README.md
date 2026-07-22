# VentaSmart — Flutter E-commerce App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)](https://flutter.dev)
[![Tests](https://img.shields.io/badge/tests-38%20passed-brightgreen)](https://github.com/Navas20/VentaSmart)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

App mobile de e-commerce construida con Flutter, Riverpod como gestor de estado y Floor ORM para persistencia local con SQLite.

## Tech Stack

| Capa | Tecnología |
|---|---|
| Framework | Flutter 3.x |
| State Management | Riverpod + Provider |
| Navegación | GoRouter |
| Persistencia | Floor ORM + SQLite |
| UI | Material 3 + Dark Mode |
| Testing | Flutter Test (38 tests) |

## Características

- 7 pantallas funcionales (catálogo, carrito, checkout, perfil, favoritos, órdenes, detalle de producto)
- 4 DAOs con Floor ORM para operaciones CRUD locales
- Carrito persistente con SQLite (sobrevive cierres de app)
- Material 3 con tema claro y oscuro
- Búsqueda y filtros por categoría y precio
- 38 tests automatizados (unitarios + widgets)

## Arquitectura

```
lib/
├── models/      # Entidades y DAOs (Floor)
├── providers/   # Riverpod providers
├── screens/     # 7 pantallas
├── widgets/     # Componentes reutilizables
└── test/        # 38 tests
```

## Instalación

```bash
flutter pub get
flutter run
```
