import 'package:flutter/material.dart';

// * WIDGETS
import './upcoming_pay.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final payments = [
      {'title': 'YouTube Music', 'days': 15, 'amount': 75.00},
      {'title': 'Gemini Pro', 'days': 25, 'amount': 30.00},
      {'title': 'Eleven Labs', 'days': 30, 'amount': 38.00},
      {'title': 'Spotify', 'days': 5, 'amount': 45.00},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Section's Head ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontFamily: 'BrunoAce',
                          color: colors.onSurface,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // - Main title
                  Text(
                    'Upcoming Payments',
                    style: TextStyle(
                      fontFamily: 'BrunoAce',
                      color: colors.tertiary,
                      fontSize: 17,
                      shadows: [
                        Shadow( 
                          color: colors.tertiary.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // - "View All"
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'BrunoAce',
                    color: colors.onSurface,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // --- Carousel ---
        SizedBox(
          height: 180, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20.0), // : Initial padding for the first item
            itemCount: payments.length,
            // : Bouncing effect for a smoother scroll experience
            physics: const BouncingScrollPhysics(), 
            itemBuilder: (context, index) {
              final payment = payments[index];
              return UpcomingPay(
                title: payment['title'] as String,
                daysLeft: payment['days'] as int,
                amount: payment['amount'] as double,
                onPaid: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}