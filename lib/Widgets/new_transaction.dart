import 'package:flutter/Material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTX;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(this.addTX);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
            ),
            TextButton(
              onPressed: () {
                addTX(
                    titleController.text, double.parse(amountController.text));
              },
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
