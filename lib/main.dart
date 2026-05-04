import 'package:flutter/material.dart';
import 'package:gvaf_finance_app/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp.router(
      title: 'Finance Manager',
      routerConfig: appRouter,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFFFF0088),
          contentTextStyle: TextStyle(color: Color(0xFF1E1E1E)),
        ),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E6E6),
          secondary: Color(0xFF00B3B3),
          tertiary: Color(0xFFFF0088),
          onPrimary: Color(0xFF1E1E1E),
          surface: Color(0xFF4D4D4D),
          onSurface: Color(0xFFCECECE),
        )
      )
    );
  }
}
