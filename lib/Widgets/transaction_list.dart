import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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
      children: _usrtxs.map((tx) {
        return Card(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.purple,
                  width: 2,
                )),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Text(
                  '\$ ${tx.amount}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat('yyyy/MM/dd').format(tx.date).toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
