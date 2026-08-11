import 'package:flutter/material.dart';

// * Widgets
import 'package:gvaf_finance_app/widgets/header_page.dart';
import 'package:gvaf_finance_app/widgets/options_section.dart';
import 'package:gvaf_finance_app/widgets/profile_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderPage(titlePage: 'Profile'),
          SizedBox(height: 20),
          ProfileSection(),
          SizedBox(height: 20),
          OptionsSection()
        ],
      ),
    );
  }
}