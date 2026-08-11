import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// * WIDGETS
import './upcoming_pay.dart';

class UpcomingSection extends StatefulWidget {
  const UpcomingSection({super.key});

  @override
  State<UpcomingSection> createState() => _UpcomingSectionState();
}

class _UpcomingSectionState extends State<UpcomingSection> {

  @override 
  void initState() {
    super.initState();
    getAllPayments();
  }

  var payments = [];
  Future<void> getAllPayments() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser?.id;

    var data = await supabase.from('upcoming_pays').select().eq('id_user', user!);

    if(!mounted) return;
    setState(() {
      payments = data;
    });
  }

  int getRemainingDays(String date) {
    final DateTime dueDate = DateTime.parse(date);
    final DateTime today = DateTime.now();
    final int daysLeft = dueDate.difference(today).inDays;

    return daysLeft;
  }

  Future<void> markPaymentAsPaid(String payId) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    try {
      await supabase.rpc('process_upcoming_payment', params: 
        {
          'p_payment_id': payId,
          'p_user_id': userId
        }
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pay successfully', style: TextStyle(fontFamily: 'Bruce Ace')),
          backgroundColor: Color(0xFF00E5FF),
        ),
      );
      await getAllPayments();
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error', style: const TextStyle(fontFamily: 'Bruce Ace')),
          backgroundColor: const Color(0xFFFF1744),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

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
                        payments.length.toString(),
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
                daysLeft: getRemainingDays(payment['payment_date']),
                amount: payment['amount'] as double,
                onPaid: () => markPaymentAsPaid(payment['id'] as String),
              );
            },
          ),
        ),
      ],
    );
  }
}