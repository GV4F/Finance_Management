import 'package:flutter/material.dart';
import '../utils/formatAmount.dart';

class UpcomingPay extends StatelessWidget {
  final String title;
  final int daysLeft;
  final double amount;
  final VoidCallback onPaid;

  const UpcomingPay({
    super.key,
    required this.title,
    required this.daysLeft,
    required this.amount,
    required this.onPaid,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16.0, bottom: 20.0), // : Margin between cards
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary,
            colors.secondary.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- Title ---
            Text(
              title,
              style: TextStyle(
                fontFamily: 'BrunoAce',
                color: colors.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // : If the title is too long, it will be truncated with an ellipsis
            ),
            
            const SizedBox(height: 12),

            // --- Days Left and Amount ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.tertiary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$daysLeft days',
                    style: const TextStyle(
                      fontFamily: 'BrunoAce',
                      color: Colors.white,
                      fontSize: 7,
                    ),
                  ),
                ),
                Text(
                  formatAmount(amount),
                  style: TextStyle(
                    fontFamily: 'BrunoAce',
                    color: colors.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- "PAID" Button ---
            GestureDetector(
              onTap: onPaid,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: colors.onPrimary, 
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Paid',
                    style: TextStyle(
                      fontFamily: 'BrunoAce',
                      color: colors.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}