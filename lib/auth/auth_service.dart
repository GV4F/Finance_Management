import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabaseClient = Supabase.instance.client;
  
  // - SIGN IN WITH EMAIL AND PASSWORD
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password
    );
  }

  // - SIGN UP WITH EMAIL AND PASSWORD
  Future<AuthResponse> signUpWithEmail(String name, String email, String password) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
      }
    );
  }

  // - GET CURRENT USER
  String? getCurrentUser() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // - SIGN OUT
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}