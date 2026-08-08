import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/header_page.dart';
import '../widgets/historial_section.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderPage(titlePage: 'Historial'),
          Expanded(child: HistorialSection()),
        ],
      ),
    );
  }
}