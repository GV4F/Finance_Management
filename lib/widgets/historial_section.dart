import 'package:flutter/material.dart';

// * WIDGETS
import '../widgets/historial_card.dart';

class HistorialSection extends StatefulWidget {
  const HistorialSection({super.key});

  @override
  State<HistorialSection> createState() => _HistorialSectionState();
}

class _HistorialSectionState extends State<HistorialSection> {
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final transactions = [
      {'title': 'Soldering Iron 90w', 'date': 'March 29 - 12:00 PM', 'amount': '- Q.500.00', 'isIncome': false},
      {'title': 'Pay For Mobile App', 'date': 'March 30 - 1:00 PM', 'amount': '+ Q.5,000.00', 'isIncome': true},
      // Nota: En tu imagen 'Saving' tiene un color un poco distinto, pero lo tomaré como ingreso positivo por ahora
      {'title': 'Saving', 'date': 'March 30 - 6:00 PM', 'amount': '+ Q.1,500.00', 'isIncome': true},
      {'title': 'White Monster', 'date': 'March 30 - 6:00 PM', 'amount': '- Q.17.00', 'isIncome': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Transaction',
                style: TextStyle(
                  fontFamily: 'BrunoAce',
                  color: colors.secondary,
                  fontSize: 17
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'BrunoAce',
                    color: colors.surface,
                    fontSize: 14
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // - Section Content
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          physics: const BouncingScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            return HistorialCard(
              title: tx['title'] as String,
              date: tx['date'] as String,
              amount: tx['amount'] as String,
              type: tx['isIncome'] as bool,
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}