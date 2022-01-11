import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/new_transaction.dart';
import 'Models/Transaction.dart';
import 'Widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  fontFamily: 'QuickSand',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple, accentColor: Colors.amber),
          appBarTheme: AppBarTheme.of(context).copyWith(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _addnewtransaction(String newTitle, double newAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: DateTime.now());

    setState(() {
      _usrtxs.add(newTx);
    });
  }

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

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addnewtransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                color: Colors.blue,
                elevation: 3,
                margin: EdgeInsets.all(5),
                child: Text('Charts of Transaction'),
              ),
            ),
            TransactionList(_usrtxs)
          ],
        ),
      ),
    );
  }
}
