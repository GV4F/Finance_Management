import 'package:flutter/material.dart';
import 'package:gvaf_finance_app/router.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'utils/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top]
  );

  await Supabase.initialize(
    url: EnvConfig.url,
    anonKey: EnvConfig.anonKey,
  );

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
        fontFamily: 'BrunoAce',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xFFFF0088),
          contentTextStyle: TextStyle(color: Color(0xFF1E1E1E)),
        ),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E6C0),
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