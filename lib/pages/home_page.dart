import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/main_header.dart';
import '../widgets/actions_section.dart';

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
          const SizedBox(height: 20),
          const ActionsSection(),
        ],
      )
    );
  }
}