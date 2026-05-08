import 'package:flutter/material.dart';

// * WIDGETS
import './action_button.dart';

class ActionsSection extends StatelessWidget {
  const ActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          icon: Icons.money_off_outlined,
          bottomText: 'Expense',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.attach_money_outlined,
          bottomText: 'Income',
          onTap: () {},
        ),
        ActionButton(
          icon: Icons.savings,
          bottomText: 'Savings',
          onTap: () {},
        ),
      ],
    );
  }
}