import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _expenseList = [];

  void _addExpense() async {
    var newExpense = await showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const NewExpense());
    if (newExpense != null) {
      setState(() {
        _expenseList.add(newExpense);
      });
    }
  }

  void _onRemoveExpense(Expense expense) {
    var expenseIndex = _expenseList.indexOf(expense);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${expense.title} removed!"),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _expenseList.insert(expenseIndex, expense);
          });
        },
      ),
    ));
    setState(() {
      _expenseList.remove(expense);
    });
  }

  Widget mainContent = const Center(
    child: Text("No expenses added yet!"),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _addExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < height
          ? Column(
              children: [
                Chart(expenses: _expenseList),
                Expanded(
                    child: _expenseList.isEmpty
                        ? mainContent
                        : ExpenseList(
                            expenseList: _expenseList,
                            onRemoveExpense: _onRemoveExpense,
                          ))
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenseList)),
                Expanded(
                    child: _expenseList.isEmpty
                        ? mainContent
                        : ExpenseList(
                            expenseList: _expenseList,
                            onRemoveExpense: _onRemoveExpense,
                          ))
              ],
            ),
    );
  }
}
