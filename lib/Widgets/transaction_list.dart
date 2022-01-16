import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: transactions.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/Empty.png',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'No Expenses are added Yet!',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                            child: Text(
                          '\$${transactions[index].amount}',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      DateFormat.yMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteTx(transactions[index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
