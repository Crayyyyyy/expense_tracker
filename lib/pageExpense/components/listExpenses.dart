import 'package:expense_tracker/pageExpense/components/expense.dart';
import 'package:flutter/material.dart';

class ListExpenses extends StatelessWidget {
  List<Expense> list;
  void Function(Expense expense) onDismissedExpense;

  ListExpenses({
    super.key,
    required this.list,
    required this.onDismissedExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(list[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          onDismissedExpense(list[index]);
        },
        child: TileExpense(
          expense: list[index],
        ),
      ),
      itemCount: list.length,
    );
  }
}

class TileExpense extends StatelessWidget {
  TileExpense({super.key, required this.expense});

  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${expense.amount.toString()} €'),
        subtitle: Text(expense.title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconsCategory[expense.category]),
            Text(expense.formattedDate),
          ],
        ),
      ),
    );
  }
}
