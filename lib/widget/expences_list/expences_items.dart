import 'package:flutter/material.dart';

import '../../model/expens.dart';

class ExpencesItem extends StatelessWidget {
  const ExpencesItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                  ),
                  //34.5463 => 34.54
                  const Spacer(),
                  Row(
                    children: [
                      Icon(catagoeyIcon[expense.catagory]),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(expense.formattDate),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
