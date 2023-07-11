import 'expense.dart';

class ExpenseBucket {
  final Category category;
  final List<Expense> expenseList;

  ExpenseBucket({required this.category, required this.expenseList});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenseList = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenseList) {
      sum += expense.amount;
    }

    return sum;
  }
}
