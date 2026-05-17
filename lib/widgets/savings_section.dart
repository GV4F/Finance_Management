import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/savings_card.dart';

class SavingsSection extends StatefulWidget {
  const SavingsSection({super.key});

  @override
  State<SavingsSection> createState() => _SavingsSectionState();
}

class _SavingsSectionState extends State<SavingsSection> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final percentage = 0.6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Savings',
                style: TextStyle(
                  fontFamily: 'BrunoAce',
                  color: colors.secondary,
                  fontSize: 17,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'BrunoAce',
                    color: colors.surface,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: 24.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB95CE4), colors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.savings_outlined,
                      size: 64.0,
                      color: colors.onPrimary,
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Main Savings",
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'BrunoAce',
                      ),
                    ),
                    Text(
                      "Q.1,800.00",
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BrunoAce',
                      ),
                    ),
                    const SizedBox(height: 15.0),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double maxWidth = constraints.maxWidth;
                        final double fillWidth = maxWidth * percentage;

                        return Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(
                              height: 22.0,
                              width: maxWidth,
                              decoration: BoxDecoration(
                                color: colors.onPrimary,
                                borderRadius: BorderRadius.circular(11.0),
                              ),
                            ),

                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic,
                              height: 22.0,
                              width: fillWidth,
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(11.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors.primary.withValues(
                                      alpha: 0.5,
                                    ),
                                    blurRadius: 8.0,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),

                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  "${(percentage * 100).toInt()}%",
                                  style: TextStyle(
                                    color: percentage > 0.50
                                        ? colors.onPrimary
                                        : colors.primary,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16.0),

                    Text(
                      'Total to Save: Q.3,000.00',
                      style: TextStyle(
                        color: colors.surface,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BrunoAce',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

              const SavingsCard(
                title: "Main Savings",
                savedAmount: 2800,
                goalAmount: 3000,
                // onEdit: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
