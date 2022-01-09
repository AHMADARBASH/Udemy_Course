import 'package:flutter/material.dart';
import '../Widgets/transaction_list.dart';
import 'new_transaction.dart';
import '../Models/Transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

void _addnewtransaction(String newTitle, double newAmount) {
  final newTx = Transaction(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: DateTime.now());
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _usrtxs = [
    Transaction(
      id: '1',
      title: 'new shoe',
      amount: 50.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'new Hat',
      amount: 4.5,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        TransactionList(_usrtxs),
      ],
    );
  }
}
