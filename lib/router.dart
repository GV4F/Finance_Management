import 'package:go_router/go_router.dart';

// * PAGES
import './pages/home_page.dart';
import './pages/historial_page.dart';
import './pages/savings_page.dart';
import './pages/profile_page.dart';
import './pages/main_page.dart';

final GoRouter appRouter = GoRouter(

  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
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