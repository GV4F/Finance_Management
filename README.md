<div align="center">

  <img src="/assets/images/Logo.png" alt="GVAF Logo" width="120" />

  # 🚀 GVAF — Personal Finance Management

  **Una aplicación móvil de finanzas personales con estética Cyberpunk / Industrial construida para tomar el control absoluto de tu dinero.**

  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
  [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

</div>

---

## 📌 Sobre el Proyecto

**Finance management - GVAF** nació como una solución personal para identificar, rastrear y recortar gastos innecesarios. A diferencia de las aplicaciones financieras tradicionales, esta combina un motor de base de datos robusto en la nube con una **interfaz de usuario táctil, e inmersiva** inspirada en estéticas cyberpunk/industrial.

Realmente este es más un proyecto personal que decidí crear para poder tener un mayor control de mis finanzas. Aunque al inicio la aplicación fue pensada para ser de uso exclusivamente personal, también fue preparada para manejar **múltiples clientes**, cada quien teniendo privacidad total.

Una de las razones por las que decidí hacer mi propia app fue porque las apps comerciales de manejo de finanzas son muy **cuadradas** en su mayoría, además de que algunas necesitas pagar para poder acceder a ciertas funciones, otras tienen interfaces demasiado simples o por el contrario demasiado "complejas" para mí gusto, por eso decidí hacer una aplicación adaptaba a mis necesidades y con **un punto intermedio entre lo simple y lo complejo.** 

**Intenté agregar todas las funciones necesarias para un buen manejo de finanzas, pero sí tú tienes más ideas o te gustaría tener acceso a la app, será un gusto charlar contigo por medio de mi correo.😉**

## 🎬 Demo & Capturas

### 📱 Vistas Principales

| Welcome / Auth | Dashboard / Home | Historial | Savings / Metas | Perfil |
| :---: | :---: | :---: | :---: | :---: |
| <img src="/assets/images/Welcome_finance.webp" width="160"/> | <img src="/assets/images/Login_finance.webp" width="160"/> | <img src="/assets/images/Home_finance.webp" width="160"/> | <img src="https://via.placeholder.com/200x400" width="160"/> | <img src="/assets/images/Profile_finance.webp" width="160"/> |



https://github.com/user-attachments/assets/7db4f11d-b829-4e35-98e6-fca2fde88479




---

## ✨ Características Clave

* 🛡️ **Autenticación Segura & AuthGate:** Flujo dinámico entre *Welcome*, *Login* y *Sign Up* respaldado por Supabase Auth.
* 👁️ **Control de Privacidad de Saldo:** Toggle interactivo para ocultar/mostrar balances en tiempo real.
* ⚡ **Historial e Inversión de Transacciones:** Consulta detallada de ingresos/gastos con la capacidad de revertir transacciones ejecutando funciones RPC automáticas en la base de datos.
* 🎯 **Metas de Ahorro Dinámicas:** Visualización de progreso con cálculo matemático defensivo (prevención de división por cero y desbordamiento visual).
* 📅 **Carrusel de Pagos Próximos (Upcoming Payments):** Contador dinámico de días restantes con alertas en carmesí neón e incremento automático de fechas de vencimiento al marcar como pagado.
* 📸 **Perfiles Personalizados:** Carga y actualización de avatares de usuario usando Supabase Storage con carpetas aisladas por UUID.
* 🎨 **UI/UX Cyberpunk Glassmorphism:** Componentes hechos a medida con bordes translúcidos, resplandor neón (`glow`) y tipografía personalizada (*Bruno Ace*).

---

## 🛠️ Arquitectura & Stack Tecnológico

### Frontend
* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **Enrutamiento:** `go_router` (manejo de rutas declarativas y ShellRoute para navegación persistente)
* **UI/Style:** Custom `BackdropFilter` (Glassmorphism), `CustomPainter`, y Layouts responsivos con `LayoutBuilder`.

### Backend & Database (Supabase)
* **Database:** PostgreSQL.
* **Seguridad (RLS):** *Row Level Security* activo en todas las tablas (`users`, `accounts`, `transactions`, `savings`, `upcoming_payments`) restringiendo el acceso por `auth.uid()`.
* **Funciones Almacenadas (RPC) & Triggers:** * `update_balance()`: Transacciones atómicas de actualización de fondos.
  * `handle_new_user()`: Trigger automatizado para inicializar registros en `public.users` y `balances` tras el registro en `auth.users`.
* **Storage:** Buckets públicos configurados con políticas de modificación restrictivas por usuario.

---

## 🚀 Instalación y Configuración Local

Si deseas clonar y ejecutar este proyecto localmente:

### Prerrequisitos
* Flutter SDK (Versión `>=3.0.0`)
* Un proyecto activo en [Supabase](https://supabase.com/)

### Pasos

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/GV4F/Finance_Management.git](https://github.com/GV4F/Finance_Management.git)
   cd Finance_Management
