import 'package:flutter/material.dart';
import 'dart:ui';
import '../utils/formatAmount.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainHeader extends StatefulWidget {
  const MainHeader({super.key});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {

  @override
  void initState() {
    super.initState();
    getBalance();
    getView();
  }

  double balance = 0.0;
  bool isBalanceVisible = false;
  String userName = '';
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

  Future<void> getView() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser?.id;

    final response = await supabase.from('users').select().eq('id', user!).single();
    final bool view = response['view'] ?? false;
    final String name = response['nombre'];

    if(!mounted) return;
    setState(() {
      isBalanceVisible = view;
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: screenWidth * 0.9,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [colors.tertiary, colors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Back, $userName !',
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: colors.onPrimary,
                        size: 30,
                      ),
                      onPressed: () => {},
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: colors.onPrimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                color: colors.onSurface,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isBalanceVisible = !isBalanceVisible;
                                });
                              },
                              child: Icon(
                                isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                                color: colors.tertiary,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: isBalanceVisible ? 0.0 : 8.0,
                            sigmaY: isBalanceVisible ? 0.0 : 8.0,
                          ),
                          child: Text(
                            formatAmount(balance),
                            style: TextStyle(color: colors.primary, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}