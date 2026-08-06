import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// * WIDGETS
import '../widgets/savings_card.dart';

class SavingsSection extends StatefulWidget {
  const SavingsSection({super.key});

  @override
  State<SavingsSection> createState() => _SavingsSectionState();
}

class _SavingsSectionState extends State<SavingsSection> {

  @override
  initState() {
    super.initState();
    fetchSavingsData();
  }

  List<dynamic> savingsData = [];
  Future<void> fetchSavingsData() async {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      try {
        final data = await supabase
            .from('savings')
            .select()
            .eq('id_user', user!.id);

        setState(() {
          savingsData = data;
        });
      } catch (e) {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error fetching savings data: $e')),
          );
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final percentage = 0.6;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 12.0),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                physics: const BouncingScrollPhysics(),
                itemCount: savingsData.length,
                itemBuilder: (context, index) {
                  final saving = savingsData[index];
                  return SavingsCard(
                    title: saving['title'] as String,
                    savedAmount: (saving['actual_amount'] as num).toDouble(),
                    goalAmount: (saving['objetive_amount'] as num).toDouble(),
                    onEdit: () {
                      // Handle edit action here
                    },
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
