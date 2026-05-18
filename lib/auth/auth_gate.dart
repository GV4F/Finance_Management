import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// * PAGES
import '../pages/home_page.dart';
import '../pages/welcome_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        final user = session?.user;

        if(user != null) {
          return const HomePage();
        }
        return const WelcomePage();
      }
    );
  }
}