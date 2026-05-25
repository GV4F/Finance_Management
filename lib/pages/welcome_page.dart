import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8300B6), colors.onPrimary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.05,
            right: -40,
            child: Transform.rotate(
              angle: -0.25,
              child: Image.asset(
                'assets/images/Card.png',
                width: 300,
                fit: BoxFit.contain,
              ),
            )
          ),

          Positioned(
            top: size.height * 0.45,
            left: -90,
            child: Transform.rotate(
              angle: 0.3,
              child: Image.asset(
                'assets/images/Card.png',
                width: 280,
                fit: BoxFit.contain,
              ),
            )
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1D).withValues(alpha: 0.3),
                ),
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Easiest way \nto manage \nyour money",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'BrunoAce',
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurface,
                        height: 1.1,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/sign/signup');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.tertiary,
                            foregroundColor: colors.onPrimary,
                            elevation: 8,
                            shadowColor: colors.onPrimary.withValues(alpha: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colors.onPrimary,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.onSurface,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push('/sign/login');
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 14,
                                color: colors.tertiary,
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              )
            )
          )
        ],
      )
    );
  }
}