import 'package:flutter/material.dart';

// * Widgets
import 'package:gvaf_finance_app/widgets/header_page.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderPage(titlePage: 'Savings')
        ],
      ),
    );
  }
}