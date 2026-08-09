import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// * WIDGETS
import '../widgets/historial_card.dart';
import '../widgets/historial_modal.dart';

class HistorialSection extends StatefulWidget {
  const HistorialSection({super.key});

  @override
  State<HistorialSection> createState() => _HistorialSectionState();
}

class _HistorialSectionState extends State<HistorialSection> {

  @override
  initState() {
    super.initState();
    allTransactions();
  }

  List<dynamic> transactions = [];
  Future<void> allTransactions() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('transaction').select().order('date', ascending: false);

      setState(() {
        transactions = response as List<dynamic>;
      });

    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading transactions: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

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

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            physics: const BouncingScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return HistorialCard(
                title: tx['title'] as String,
                date: tx['date'] as String,
                amount: (tx['amount'] as num).toDouble(),
                type: ((tx['category'] as String) == 'income' ? true : false),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return HistorialModal(
                        transactionId: tx['id'] as String,
                        title: tx['title'] as String,
                        amount: (tx['amount'] as num).toDouble(),
                        date: tx['date'] as String,
                        description: tx['description'] ?? '',
                        isIncome: ((tx['category'] as String) == 'income' ? true : false),
                        onRevertSuccess: () {
                          allTransactions(); 
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}