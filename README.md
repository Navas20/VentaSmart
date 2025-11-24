

# 📱 VentaSmart — Sistema de Gestión de Ventas en Flutter

VentaSmart es una aplicación móvil desarrollada en **Flutter**, diseñada para gestionar productos, clientes y ventas de manera sencilla, rápida y elegante.  
El sistema implementa autenticación de usuarios, CRUD completo con base de datos local Floor y una interfaz moderna totalmente personalizada.

---

## 🚀 Características Principales

### 🔐 **Autenticación de Usuarios**
- Registro de nuevos usuarios.
- Inicio de sesión con correo y contraseña.
- Validación de credenciales.
- Pantalla de Login rediseñada.
- Cierre de sesión automático desde el Perfil.

---

### 👤 **Perfil del Usuario**
- Muestra nombre y correo del usuario autenticado.
- Opciones de configuración (secciones funcionales y placeholders).
- Botón de cerrar sesión que redirige al Login.

---

### 📦 **Gestión de Productos (CRUD Completo)**
- Agregar nuevos productos.
- Editar productos.
- Listado dinámico.
- Eliminar productos.
- Validación de campos.
- UI optimizada.

---

### 🧑‍🤝‍🧑 **Gestión de Clientes (CRUD Completo)**
- Registrar clientes con nombre, correo y teléfono.
- Editar datos.
- Eliminar registros.
- Pantalla visualmente mejorada.

---

### 🧾 **Gestión de Ventas**
- Selección de producto.
- Selección de cliente.
- Cantidad con slider dinámico.
- Cálculo automático del total.
- Registro de la venta.
- Eliminación de ventas.
- Vista detallada en forma de tickets.

---

### 🗄 **Base de Datos Local con Floor**
- Tablas:
  - Usuario
  - Cliente
  - Producto
  - Venta
- Controladores DAO generados automáticamente.
- Migraciones correctas para la base de datos.
- Arquitectura limpia y escalable.

---

## 🎨 UI/UX Moderno

- Colores corporativos aplicados de manera consistente:
  - Morado (primario)
  - Naranja (secundario)
  - Amarillo (terciario)
- Tarjetas con sombras suaves.
- Inputs personalizados.
- Botones redondeados.
- Menú inferior animado.
- Transiciones limpias.



## 📁 Estructura del Proyecto



lib/
├─ database/
│   ├─ app_database.dart
│   └─ dao/ (Cliente, Producto, Usuario, Ventas)
├─ models/
│   ├─ cliente.dart
│   ├─ producto.dart
│   ├─ usuario.dart
│   └─ venta.dart
├─ screens/
│   ├─ login/
│   │   ├─ login_screen.dart
│   │   └─ register_screen.dart
│   ├─ home_shell.dart
│   ├─ products_screen.dart
│   ├─ clients_screen.dart
│   ├─ sales_screen.dart
│   └─ profile_screen.dart
├─ main.dart

```

---

## 🛠 Instalación

### 1️⃣ Clonar el repositorio

```

git clone [https://github.com/Navas20/VentaSmart.git](https://github.com/Navas20/VentaSmart.git)
cd VentaSmart

```

### 2️⃣ Instalar dependencias

```

flutter pub get

```

### 3️⃣ Generar DAOs de Floor


flutter pub run build_runner build --delete-conflicting-outputs



### 4️⃣ Ejecutar la app



flutter run



---

## 📘 Tecnologías Utilizadas

| Tecnología | Uso |
|-----------|-----|
| **Flutter 3** | Framework principal |
| **Dart** | Lenguaje de programación |
| **Floor** | ORM SQLite para persistencia local |
| **Sqflite** | Motor de base de datos |
| **Material 3** | Base del diseño visual |
| **GitHub** | Control de versiones |

---

## 🎯 Objetivo del Proyecto

Construir una aplicación de ventas funcional que permita:

- Registrar productos, clientes y ventas.
- Autenticarse con usuario y contraseña.
- Mejorar la gestión comercial de pequeños negocios.
- Aplicar conceptos de programación móvil vistos en clase.

---

## 🧠 Conclusión del Proyecto

El desarrollo de *VentaSmart* permitió aplicar de manera integral los conocimientos adquiridos en programación móvil con Flutter, abarcando:

- Manejo de vistas y navegación avanzada.
- Integración de base de datos local con Floor.
- Implementación de autenticación.
- Diseño UI/UX moderno y profesional.
- Gestión completa de datos mediante CRUD.

La aplicación cumple con los requisitos del segundo corte y supera las expectativas al incluir autenticación real y manejo de usuarios.

Como proyección futura se plantea:

- Integración con Firebase.
- Generación de reportes PDF.
- Modo oscuro.
- Sincronización con API externa para respaldo en la nube.

---



---

## ⭐ Licencia

Este proyecto es de uso académico.  
Puedes utilizarlo libremente dando el respectivo crédito.

```



