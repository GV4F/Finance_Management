import 'package:flutter/material.dart';

// * Widgets
import 'package:gvaf_finance_app/widgets/header_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderPage(titlePage: 'Profile')
        ],
      ),
    );
  }
}