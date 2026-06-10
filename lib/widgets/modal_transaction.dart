import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModalTransaction extends StatefulWidget {
  final String type;
  const ModalTransaction({
    super.key,
    required this.type
  });

  @override
  State<ModalTransaction> createState() => _ModalTransactionState();
}

class _ModalTransactionState extends State<ModalTransaction> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    typeController.dispose();
    super.dispose();
  }

  Future<void> registerTransaction({
    required String title,
    required String description,
    required double amount,
    required String type
  }) async {
    final supabase = Supabase.instance.client; 
    try {
      await supabase.from('transaction').insert({
        'title': title,
        'description': description,
        'amount': amount,
        'type': type,
        'category': widget.type,
      });
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction registered successfully!')),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: colors.onPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.type == 'income' ? 
              'Income' :
              widget.type == 'expense' ?
              'Expense':
              'Saving',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                registerTransaction(
                  title: titleController.text,
                  description: descriptionController.text,
                  amount: double.parse(amountController.text),
                  type: typeController.text,
                );
              },
              child: Container(
                width: 280,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: colors.secondary, 
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: colors.onPrimary,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: colors.onPrimary,
                    fontFamily: 'Bruce Ace',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}