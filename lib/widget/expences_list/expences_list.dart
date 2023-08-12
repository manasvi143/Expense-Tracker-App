import 'package:expence_tracker/model/expens.dart';
import 'package:expence_tracker/widget/expences_list/expences_items.dart';

import 'package:flutter/material.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList({
    super.key,
    required this.expences,
    required this.onRemove,
  });

  final void Function(Expense expensess) onRemove;
  final List<Expense> expences;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expences.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            // color: kColorScheme.errorContainer,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 0, 0)
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: const Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          secondaryBackground: Container(
            // color: kColorScheme.errorContainer,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 255, 255, 255),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.delete,
                  ),
                ],
              ),
            ),
          ),
          key: ValueKey(expences[index]),
          onDismissed: (direction) {
            onRemove(expences[index]);
          },
          child: ExpencesItem(
            expense: expences[index],
          ),
        ),
      ),
    );
  }
}
