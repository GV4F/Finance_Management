import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingAddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.20,
      right: MediaQuery.of(context).size.width * 0.05,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.onPrimary.withValues(alpha: 0.9),
            border: Border.all(
              color: colors.primary, 
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.2),
                blurRadius: 15.0,
                spreadRadius: 2.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.add,
            color: colors.primary,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}