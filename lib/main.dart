import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widgets/chart.dart';
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
                fontSize: 20),
            button: TextStyle(color: Colors.white)),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple, accentColor: Colors.amber),
        appBarTheme: AppBarTheme.of(context).copyWith(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
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

  void _addnewtransaction(String newTitle, double newAmount, DateTime newDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: newDate);

    setState(() {
      _usrtxs.add(newTx);
    });
  }

  final List<Transaction> _usrtxs = [];

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addnewtransaction);
        });
  }

  List<Transaction> get _recentTransactoin {
    return _usrtxs.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      _usrtxs.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar mybar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
          onPressed: () => startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: mybar,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        mybar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: Chart(_recentTransactoin)),
            Container(
              height: (MediaQuery.of(context).size.height -
                      mybar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.8,
              child: TransactionList(_usrtxs, deleteTransaction),
            )
          ],
        ),
      ),
    );
  }
}
