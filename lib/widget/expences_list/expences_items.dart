import 'package:expence_tracker/widget/expences_list/edit_expense.dart';
import 'package:flutter/material.dart';

import '../../model/expens.dart';

class ExpencesItem extends StatefulWidget {
  const ExpencesItem({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  State<ExpencesItem> createState() {
    return _ExpenseItemState();
  }
}

class _ExpenseItemState extends State<ExpencesItem> {
  void _openEditingsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) =>
          EditExpense(editExpense: widget.expense, editComplete: editiResult),
    );
  }

  void editiResult(Expense editedExpense) {
    setState(() {
      widget.expense = editedExpense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.expense.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: _openEditingsheet,
                      icon: const Icon(
                        Icons.mode_edit_outline_outlined,
                        size: Checkbox.width,
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    '\$${widget.expense.amount.toStringAsFixed(2)}',
                  ),
                  //34.5463 => 34.54
                  const Spacer(),
                  Row(
                    children: [
                      Icon(catagoeyIcon[widget.expense.catagory]),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(widget.expense.formattDate),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
