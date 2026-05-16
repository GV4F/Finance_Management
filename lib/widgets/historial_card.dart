import 'dart:ui';
import 'package:flutter/material.dart';

class HistorialCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool type;
  final VoidCallback onTap;

  const HistorialCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: (type ? colors.primary : colors.tertiary).withValues(alpha: 0.5),
              highlightColor: Colors.white.withValues(alpha: 0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C34).withValues(alpha: 0.4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'BrunoAce',
                              color: colors.secondary,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'BrunoAce',
                              color: colors.surface,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      amount,
                      style: TextStyle(
                        fontFamily: 'BrunoAce',
                        color: type ? colors.primary : colors.tertiary,
                        fontSize: 10,
                        shadows: [
                          Shadow(
                            color: (type ? colors.primary : colors.tertiary).withValues(alpha: 0.5),
                            blurRadius: 8,
                          )
                        ]
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