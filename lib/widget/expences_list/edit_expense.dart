import 'package:expence_tracker/model/expens.dart';
import 'package:flutter/material.dart';

class EditExpense extends StatefulWidget {
  const EditExpense(
      {required this.editExpense, super.key, required this.editComplete});
  final Expense editExpense;
  final void Function(Expense resultExpense) editComplete;

  @override
  State<EditExpense> createState() {
    return _EditExpenseState();
  }
}

class _EditExpenseState extends State<EditExpense> {
  final editedTextController = TextEditingController();
  final editedAmountController = TextEditingController();
  DateTime? selectedDate;
  Catagory selectedCatagory = Catagory.leisure;

  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    var datepicked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    if (datepicked == null) {
      return;
    }

    setState(() {
      selectedDate = datepicked;
    });
  }

  void finaChanges() {
    var enterdAmount = double.tryParse(editedAmountController.text);
    final amountIsInvalid = enterdAmount == null || enterdAmount <= 0;

    if (editedTextController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text(
              'Please make sure a valid title, amount, date, and catagory is selected'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    Expense temExpense = Expense(
        amount: enterdAmount,
        date: selectedDate as DateTime,
        title: editedTextController.text,
        catagory: selectedCatagory);
    widget.editComplete(temExpense);

    Navigator.pop(context);
  }

  @override
  void initState() {
    editedTextController.text = widget.editExpense.title;
    editedAmountController.text = widget.editExpense.amount.toString();
    selectedDate = widget.editExpense.date;
    selectedCatagory = widget.editExpense.catagory;

    super.initState();
  }

  @override
  void dispose() {
    editedTextController.dispose();
    editedAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // editedTextController.text = widget.editExpense.title;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            style: const TextStyle(
                color: Color.fromARGB(255, 130, 122, 7),
                fontWeight: FontWeight.w400,
                fontSize: 18),
            controller: editedTextController,
            maxLength: 50,
            decoration: const InputDecoration(
                label: Text(
              'Title',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 130, 122, 7),
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  controller: editedAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹',
                    label: Text(
                      'Amount',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                formatter.format(selectedDate!),
                style: const TextStyle(
                    color: Color.fromARGB(255, 130, 122, 7),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              IconButton(
                  onPressed: datePicker,
                  icon: const Icon(Icons.calendar_month_outlined))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              DropdownButton(
                items: Catagory.values
                    .map(
                      (temp) => DropdownMenuItem(
                        value: temp,
                        child: Text(
                          temp.name.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCatagory = value!;
                  });
                },
                value: selectedCatagory,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )),
              ElevatedButton(
                onPressed: finaChanges,
                child: const Text(
                  "save",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
