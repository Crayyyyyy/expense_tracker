import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { leisure, food, travel, work, other }

const iconsCategory = {
  Category.leisure: Icons.sports_gymnastics_outlined,
  Category.food: Icons.food_bank,
  Category.travel: Icons.flight,
  Category.work: Icons.card_travel,
  Category.other: Icons.help_outline_sharp,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.timestamp,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime timestamp;
  final Category category;

  String get formattedDate {
    return formatter.format(timestamp);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.fromAll(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
