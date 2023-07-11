import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expense_list_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {required this.onRemoveExpense, required this.expenseList, super.key});
  final List<Expense> expenseList;
  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenseList.length,
        itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.6),
              ),
              onDismissed: (direction) => onRemoveExpense(expenseList[index]),
              key: ValueKey(expenseList[index]),
              child: ExpenseListItem(
                expense: expenseList[index],
              ),
            ));
  }
}
