import 'package:expence_tracker/model/expens.dart';
import 'package:expence_tracker/widget/expences_list/expences_items.dart';
import 'package:flutter/material.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList(
      {super.key, required this.expences, required this.onRemove});

  final void Function(Expense expensess) onRemove;
  final List<Expense> expences;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expences.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(expences[index]),
          onDismissed: (direction) {
            onRemove(expences[index]);
          },
          child: ExpencesItem(
            expences[index],
          ),
        ),
      ),
    );
  }
}
