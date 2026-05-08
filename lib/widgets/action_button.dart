import 'dart:ui';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String bottomText;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.bottomText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 110,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      // ClipRRect recorta el efecto de cristal para que no se salga de las esquinas redondeadas
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0), 
          child: Material(
            color: Colors.transparent, 
            child: InkWell(
              onTap: onTap,
              splashColor: colors.secondary,
              highlightColor: Colors.white.withValues(alpha: 0.05),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C34).withValues(alpha: 0.5), 
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08), 
                    width: 1.5,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        icon,
                        color: colors.tertiary,
                        size: 28,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add',
                            style: const TextStyle(
                              fontFamily: 'BrunoAce', 
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            bottomText,
                            style: TextStyle(
                              fontFamily: 'BrunoAce',
                              color: colors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: colors.secondary.withValues(alpha: 1.6),
                                  blurRadius: 8,
                                )
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}