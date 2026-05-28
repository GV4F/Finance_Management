import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/input_sign.dart';

class SignPage extends StatefulWidget {
  final bool isLogin;
  const SignPage({
    super.key,
    required this.isLogin
  });

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {

  final authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8300B6), colors.onPrimary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.isLogin ? 'Login' : 'Sign Up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 40),

            if(!widget.isLogin) ... [
              InputSign(
                hinText: 'Username',
                icon: Icons.person_outline,
                controller: _usernameController,
              ),
              const SizedBox(height: 10),
            ],

            InputSign(
              hinText: 'Email',
              icon: Icons.email_outlined,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            InputSign(
              hinText: 'Password',
              icon: Icons.lock_outlined,
              controller: _passwordController,
              isPassword: true,
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  elevation: 8,
                  shadowColor: colors.onPrimary.withValues(alpha: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(widget.isLogin ? 'Login' : 'Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            )
          ],
        ),
      )
    );
  }
}