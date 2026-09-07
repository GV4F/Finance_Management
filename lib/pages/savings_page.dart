import 'package:flutter/material.dart';

// * Widgets
import '../widgets/header_page.dart';
import '../widgets/savings_section.dart';
import '../widgets/floating_add_button.dart';
import '../widgets/add_saving_modal.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  final GlobalKey<SavingsSectionState> _savingsSectionKey = GlobalKey<SavingsSectionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderPage(titlePage: 'Savings'),
          const SizedBox(height: 20),
          SavingsSection(key: _savingsSectionKey),
        ],
      ),
      floatingActionButton: FloatingAddButton(
        onTap: () async {
          final result = await showDialog<bool>(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.6),
            builder: (BuildContext context) {
              return const AddSavingModal(); 
            },
          );
          if (result == true) {
            _savingsSectionKey.currentState?.fetchSavingsData();
          }
        },
      ),
    );
  }
}