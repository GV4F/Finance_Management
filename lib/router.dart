import 'package:go_router/go_router.dart';
import 'package:gvaf_finance_app/auth/auth_gate.dart';

// * PAGES
// import './pages/home_page.dart';
import './pages/historial_page.dart';
import './pages/savings_page.dart';
import './pages/profile_page.dart';
import './pages/main_page.dart';

final GoRouter appRouter = GoRouter(

  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/historial',
          builder: (context, state) => const HistorialPage(),
        ),
        GoRoute(
          path: '/savings',
          builder: (context, state) => const SavingsPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        )
     ]
    )
  ]
);