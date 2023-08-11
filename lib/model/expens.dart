import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Catagory { food, travel, leisure, work }

const catagoeyIcon = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.leisure: Icons.movie,
  Catagory.work: Icons.work,
};

class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.catagory,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Catagory catagory;

  String get formattDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.catagory, required this.expenses});

  ExpenseBucket.forCatagory(List<Expense> allExpenses, this.catagory)
      : expenses = allExpenses
            .where((expense) => expense.catagory == catagory)
            .toList();
  final List<Expense> expenses;
  final Catagory catagory;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
