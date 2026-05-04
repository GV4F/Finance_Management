import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/main_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    // final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          MainHeader(),
        ],
      )
    );
  }
}