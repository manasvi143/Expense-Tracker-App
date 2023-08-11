import 'package:expence_tracker/model/expens.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addMyExpense, {super.key});
  final void Function(Expense expensee) addMyExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // var enteredTitle = '';
  final _textEdidtingController = TextEditingController();
  final _amountEdidtingController = TextEditingController();
  DateTime? selectedDate;
  Catagory _selectedCatagory = Catagory.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    var enteredAmount = double.tryParse(
        _amountEdidtingController.text); //'hello' => null , '12.33' => 12.33
    // ignore: unrelated_type_equality_checks
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_textEdidtingController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Inputs'),
          content: const Text(
              'Please make sure a valid title, amount, date, ans catagory is selected'),
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
    widget.addMyExpense(
      Expense(
          amount: enteredAmount,
          date: selectedDate!,
          title: _textEdidtingController.text,
          catagory: _selectedCatagory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textEdidtingController.dispose();
    _amountEdidtingController.dispose();
    super.dispose();
  }

  // void _saveInputTitle(String inputValue) {
  //   enteredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _textEdidtingController,
            // onChanged: _saveInputTitle,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountEdidtingController,
                  // onChanged: _saveInputTitle,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                      label: Text('Amount'), prefixText: '₹'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? 'No date selected'
                        : formatter.format(selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month_outlined)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                // value: _selectedCatagory,
                items: Catagory.values
                    .map(
                      (catgorry) => DropdownMenuItem(
                        value: catgorry,
                        child: Text(
                          catgorry.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCatagory = value;
                  });
                },
                value: _selectedCatagory,
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: submitExpenseData,
                child: const Text('Save expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
