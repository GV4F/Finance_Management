import 'package:flutter/material.dart';
import 'dart:ui';

class SavingsCard extends StatelessWidget {

  final String title;
  final double savedAmount;
  final double goalAmount;
  final VoidCallback? onEdit;

  const SavingsCard({
    super.key,
    required this.title,
    required this.savedAmount,
    required this.goalAmount,
    this.onEdit
  });

  @override
  Widget build(BuildContext context) {

    final double progress = goalAmount > 0
      ? (savedAmount / goalAmount).clamp(0.0, 1.0)
      : 0.0;
    final int percentage = (progress * 100).toInt();
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: colors.primary,
                      fontFamily: 'BrunoAce',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: onEdit,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: colors.secondary,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                "Saved: Q.${savedAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 14.0,
                  fontFamily: 'BrunoAce',
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                "Goal: Q.${goalAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'BrunoAce',
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 22.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.onPrimary.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: colors.onPrimary.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFCCCC),
                                Color(0xFFFF5A57),
                                Color(0xFFE02F75),
                                Color(0xFF6700A3), 
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${percentage.toString()}%",
                            style: TextStyle(
                              color: colors.onPrimary,
                              fontSize: 12.0,
                              fontFamily: 'BrunoAce',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black.withValues(alpha: 0.5),
                                  offset: const Offset(1,1),
                                )
                              ]
                            ),
                          )
                        )
                      ],
                    );
                  }
                )
              )
            ],
          )
        ),
      )
    );
  }
}