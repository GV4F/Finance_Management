import 'package:flutter/material.dart';

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
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){},
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