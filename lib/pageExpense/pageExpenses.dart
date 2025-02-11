import 'package:expense_tracker/pageExpense/components/chart.dart';
import 'package:expense_tracker/pageExpense/components/expense.dart';
import 'package:expense_tracker/pageExpense/components/formExpense.dart';
import 'package:expense_tracker/pageExpense/components/listExpenses.dart';
import 'package:flutter/material.dart';

class PageExpenses extends StatefulWidget {
  const PageExpenses({super.key});

  @override
  State<PageExpenses> createState() => _PageExpensesState();
}

class _PageExpensesState extends State<PageExpenses> {
  final List<Expense> _expenses = [
    Expense(
      title: "Groceries",
      amount: 25.4,
      timestamp: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Deadpool",
      amount: 9.99,
      timestamp: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Plane",
      amount: 59.45,
      timestamp: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Monitor",
      amount: 249.49,
      timestamp: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

    Widget buttonAdd = IconButton(
      icon: const Icon(
        Icons.add,
        color: Color(0xFF8d99ae),
      ),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (ctx) {
              return FormExpense(onAddExpense: _addExpense);
            });
      },
    );

    Widget textTitle = const Text(
      "Expenses tracker",
    );

    return Scaffold(
      appBar: AppBar(
        title: textTitle,
        actions: [buttonAdd],
      ),
      body: isPortrait
          ? Column(
              children: [
                Chart(expenses: _expenses),
                Expanded(
                  child: ListExpenses(
                      list: _expenses, onDismissedExpense: _removeExpense),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expenses)),
                Expanded(
                  child: ListExpenses(
                      list: _expenses, onDismissedExpense: _removeExpense),
                ),
              ],
            ),
    );
  }
}
