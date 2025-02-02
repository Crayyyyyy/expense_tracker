import 'package:expense_tracker/pageExpense/components/expense.dart';
import 'package:flutter/material.dart';

class FormExpense extends StatefulWidget {
  FormExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<FormExpense> createState() => _FormExpenseState();
}

class _FormExpenseState extends State<FormExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _pickedDate = DateTime.now();
  String? _pickedTitle;
  String? _pickedAmount;
  Category? _pickedCategory = Category.other;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final last = DateTime(now.year + 1, now.month, now.day);
    final dateTemp = await showDatePicker(
        context: context, firstDate: now, lastDate: last, initialDate: now);

    if (dateTemp == null) return;

    setState(() {
      _pickedDate = dateTemp;
    });
  }

  void _submit() {
    bool validExpenseEntered = true;

    final amountConverted =
        double.tryParse(_pickedAmount ?? "This returns null");

    if (amountConverted == null || amountConverted < 0) {
      validExpenseEntered = false;
      print("Amount is incorrect");
    }
    if (_pickedTitle == null) {
      validExpenseEntered = false;
      print("One of the other three is null");
    }

    print(amountConverted);
    print(_pickedTitle);
    print(_pickedDate);
    print(_pickedCategory);
    print("----------------------");

    if (validExpenseEntered == false) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Invalid input"),
              content: const Text("At least title and amount must be entered."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Okay"),
                )
              ],
            );
          });
      return;
    }

    Expense expenseTemp = Expense(
        title: _pickedTitle!,
        amount: amountConverted!,
        timestamp: _pickedDate!,
        category: _pickedCategory!);
    widget.onAddExpense(expenseTemp);

    _pickedDate = DateTime.now();
    _pickedTitle = null;
    _pickedAmount = null;
    _pickedCategory = Category.other;

    Navigator.of(context).pop();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputTitle = Expanded(
      child: TextField(
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        controller: _titleController,
        onChanged: (value) {
          _pickedTitle = _titleController.text;
        },
        maxLength: 50,
        decoration: const InputDecoration(
            label: Text("Title"), hintText: "Groceries, film, taxi..."),
      ),
    );

    Widget inputAmount = Expanded(
      child: TextField(
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        controller: _amountController,
        onChanged: (value) {
          _pickedAmount = _amountController.text;
        },
        maxLength: 50,
        decoration:
            const InputDecoration(label: Text("Amount"), hintText: "49.99€"),
      ),
    );

    Widget inputDate = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _pickedDate == null
                ? "No date selected"
                : formatter.format(_pickedDate!),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () => _showDatePicker(),
          ),
        ],
      ),
    );

    Widget inputCategory = DropdownButton(
      value: _pickedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              alignment: Alignment.centerRight,
              value: category,
              child: Text(
                textAlign: TextAlign.end,
                category.name.toString().toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          _pickedCategory = value;
        });
        print(_pickedCategory);
      },
    );

    Widget buttonCancel = TextButton(
      onPressed: () => _cancel(),
      child: const Text("Cancel"),
    );

    Widget buttonSubmit = ElevatedButton(
      onPressed: () => _submit(),
      child: const Text("Submit"),
    );

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              inputTitle,
              const SizedBox(width: 20),
              inputCategory,
            ],
          ),
          Row(
            children: [
              inputAmount,
              inputDate,
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buttonCancel,
              buttonSubmit,
            ],
          ),
        ],
      ),
    );
  }
}
