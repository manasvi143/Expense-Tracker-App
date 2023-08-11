import 'package:expence_tracker/widget/charts/chart.dart';
import 'package:expence_tracker/widget/expences_list/expences_list.dart';
import 'package:expence_tracker/model/expens.dart';
import 'package:expence_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  final List<Expense> _registeredExpences = [
    Expense(
      amount: 99.99,
      date: DateTime.now(),
      title: 'Cinema',
      catagory: Catagory.leisure,
    ),
    Expense(
      amount: 122.99,
      date: DateTime.now(),
      title: 'Games',
      catagory: Catagory.work,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expenseee) {
    setState(() {
      _registeredExpences.add(expenseee);
    });
  }

  void _removeExpense(Expense expensess) {
    final removedIndex = _registeredExpences.indexOf(expensess);
    setState(() {
      _registeredExpences.remove(expensess);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Expense dleted'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _registeredExpences.insert(removedIndex, expensess);
                });
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Expanded(
      child: Center(
        child: Text('No expenses till now. Start adding new Expenses'),
      ),
    );
    if (_registeredExpences.isNotEmpty) {
      mainContent = ExpencesList(
        expences: _registeredExpences,
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpences),
          mainContent,
        ],
      ),
    );
  }
}
