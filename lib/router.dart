import 'package:go_router/go_router.dart';

// * PAGES
// import './pages/home_page.dart';
import './pages/historial_page.dart';
import './pages/savings_page.dart';
import './pages/profile_page.dart';
import './pages/main_page.dart';
import './auth/auth_gate.dart';
import './pages/sign_page.dart';

final GoRouter appRouter = GoRouter(

  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/sign/:type',
      builder: (context, state) {
        final bool isLogin = state.pathParameters['type'] == 'login' ? true : false;
        return SignPage(isLogin: isLogin);
      },
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