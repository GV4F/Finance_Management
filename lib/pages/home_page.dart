import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  double balance = 0.0;
  Future<void> getBalance() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    final response = await supabase
        .from('balances')
        .select()
        .eq('id_user', user!.id)
        .single();

    if (!mounted) return;

    setState(() {
      balance = response['general_balances'] ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              MainHeader(balance: balance),
              const SizedBox(height: 20),
              ActionsSection(getBalance: getBalance),
              const SizedBox(height: 20),
              const UpcomingSection(),
            ],
          )
        )
      )
    );
  }
}