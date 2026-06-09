import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.8,
            height: 65,
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: colors.secondary,
                  blurRadius: 9,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home_outlined),
                  color: colors.onPrimary,
                  onPressed: () => context.go('/home'),
                ),
                IconButton(
                  icon: const Icon(Icons.history_outlined),
                  color: colors.onPrimary,
                  onPressed: () => context.go('/historial'),
                ),
                IconButton(
                  icon: const Icon(Icons.savings_outlined),
                  color: colors.onPrimary,
                  onPressed: () => context.go('/savings'),
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  color: colors.onPrimary,
                  onPressed: () => context.go('/profile'),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}