import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/main_header.dart';
import '../widgets/actions_section.dart';
import '../widgets/upcoming_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              MainHeader(),
              const SizedBox(height: 20),
              const ActionsSection(),
              const SizedBox(height: 20),
              const UpcomingSection(),
            ],
          )
        )
      )
    );
  }
}