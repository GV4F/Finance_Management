import 'package:flutter/material.dart';

// * WIDGETS
import './action_button.dart';
import './modal_transaction.dart';

class ActionsSection extends StatelessWidget {
   final Future<void> Function() getBalance;
  const ActionsSection({
    super.key,
    required this.getBalance
  });

  void modalTransaction(BuildContext context, String type) {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return ModalTransaction(type: type, getBalance: getBalance);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          icon: Icons.money_off_outlined,
          bottomText: 'Expense',
          onTap: () {
            modalTransaction(context, 'expense');
          },
        ),
        ActionButton(
          icon: Icons.attach_money_outlined,
          bottomText: 'Income',
          onTap: () {
            modalTransaction(context, 'income');
          },
        ),
        ActionButton(
          icon: Icons.savings,
          bottomText: 'Savings',
          onTap: () {
            modalTransaction(context, 'saving');
          },
        ),
      ],
    );
  }
}