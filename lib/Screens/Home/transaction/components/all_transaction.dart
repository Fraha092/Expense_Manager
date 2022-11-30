import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/category/service/ExpenseIncomeService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../../models/expense_income.dart';
import '../transaction_filter_page.dart';

class AllTransaction extends StatefulWidget {
  const AllTransaction({Key? key}) : super(key: key);

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getData().then((value) {
      setState(() {
        if (value != null) {
          expenseIncomeList = value;
          for (var element in value) {
            if (element.expense != null) {
              totalExpense += element.expense ?? 0;
            }
            if (element.income != null) {
              totalIncome += element.income ?? 0;
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final CollectionReference _addIncome =
      FirebaseFirestore.instance.collection('add_income');
  final TextEditingController _datesIncome = TextEditingController();
  final TextEditingController _timesIncome = TextEditingController();
  final TextEditingController _notesIncome = TextEditingController();
  final TextEditingController _categoryIncome = TextEditingController();
  final TextEditingController _incomeIncome = TextEditingController();

  Future<void> _delete(String incomeId) async {
    await _addIncome.doc(incomeId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Transaction')));
    Navigator.pop(context);
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _datesIncome.text = documentSnapshot['dates'].toString();
      _timesIncome.text = documentSnapshot['times'].toString();
      _notesIncome.text = documentSnapshot['notes'];
      _categoryIncome.text = documentSnapshot['category'];
      _incomeIncome.text = documentSnapshot['income'].toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Updated!")));
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _datesIncome,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: 'Dates'),
                            cursorColor: Colors.teal,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                              if (pickedDate != null) {
                                setState(() {
                                  _datesIncome.text = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _timesIncome,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: 'Times'),
                            cursorColor: Colors.teal,
                            readOnly: true,
                            onTap: () async {
                              var pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (pickedTime != null) {
                                setState(() {
                                  _timesIncome.text =
                                      pickedTime.format(context);
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _notesIncome,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Notes'),
                            cursorColor: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _categoryIncome,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(labelText: 'Category'),
                            cursorColor: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _incomeIncome,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Income'),
                            cursorColor: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String dates = _datesIncome.text;
                              final String times = _timesIncome.text;
                              final String notes = _notesIncome.text;
                              final String category = _categoryIncome.text;
                              final double income =
                                  double.parse(_incomeIncome.text);
                              //final double? income=double.tryParse(_incomeIncome.text);
                              if (income != null) {
                                await _addIncome
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  "dates": dates,
                                  "times": times,
                                  "notes": notes,
                                  "category": category,
                                  "income": income
                                });
                                _datesIncome.text = '';
                                _timesIncome.text = '';
                                _notesIncome.text = '';
                                _categoryIncome.text = '';
                                double.parse(_incomeIncome.text);
                              }
                              ;
                            },
                            child: Text('Update'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ElevatedButton(
                            onPressed: () =>
                                showDialog(
                                    context: context,
                                    builder: (context)=>
                                        AlertDialog(
                                          title: Text('Delete'),
                                          content: Text('Do you want to delete this transaction record ?'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: (){
                                                  Navigator.of(context, rootNavigator: true).pop(false);
                                                },
                                                child: Text('No')),
                                            TextButton(
                                                onPressed: (){
                                                  _delete(documentSnapshot!.id);
                                                  Navigator.of(context,rootNavigator: true).pop(true);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return const TransactionPage();
                                                  }
                                                  )
                                                  );
                                                },
                                                child: Text('Yes'))
                                          ],
                                        )
                                ),
                            child: Text('Delete'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  final CollectionReference _addExpense =
      FirebaseFirestore.instance.collection('add_expense');
  final TextEditingController _datesExpense = TextEditingController();
  final TextEditingController _timesExpense = TextEditingController();
  final TextEditingController _paymentExpense = TextEditingController();
  final TextEditingController _notesExpense = TextEditingController();
  final TextEditingController _categoryExpense = TextEditingController();
  final TextEditingController _expenseExpense = TextEditingController();

  Future<void> _deletee(String expenseId) async {
    await _addExpense.doc(expenseId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Transaction')));
    //  Navigator.pop(context);
  }

  Future<void> _updatee([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _datesExpense.text = documentSnapshot['dates'].toString();
      _timesExpense.text = documentSnapshot['times'].toString();
      _notesExpense.text = documentSnapshot['notes'];
      _paymentExpense.text = documentSnapshot['payment'];
      _categoryExpense.text = documentSnapshot['category'];
      _expenseExpense.text = documentSnapshot['expense'].toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Updated!")));
    }
    await showModalBottomSheet(
      backgroundColor: Colors.grey.shade100,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _datesExpense,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: 'Dates'),
                            cursorColor: Colors.grey.shade200,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100));
                              if (pickedDate != null) {
                                setState(() {
                                  _datesExpense.text = DateFormat('yyyy-MM-dd')
                                      .format(pickedDate);
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _timesExpense,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(labelText: 'Times'),
                            cursorColor: Colors.grey.shade200,
                            readOnly: true,
                            onTap: () async {
                              var pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (pickedTime != null) {
                                setState(() {
                                  _timesExpense.text =
                                      pickedTime.format(context);
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _paymentExpense,
                            keyboardType: TextInputType.none,
                            decoration:
                                InputDecoration(labelText: 'Payment Method'),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _notesExpense,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Notes'),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _categoryExpense,
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(labelText: 'Category'),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _expenseExpense,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Expense'),
                            cursorColor: Colors.grey.shade200,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String dates = _datesExpense.text;
                              final String times = _timesExpense.text;
                              final String payment = _paymentExpense.text;
                              final String notes = _notesExpense.text;
                              final String category = _categoryExpense.text;
                              final double expense =
                                  double.parse(_expenseExpense.text);
                              //final double? expense=double.tryParse(_expenseExpense.text);
                              if (expense != null) {
                                await _addExpense
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  "dates": dates,
                                  "times": times,
                                  "payment": payment,
                                  "notes": notes,
                                  "category": category,
                                  "expense": expense
                                });
                                _datesExpense.text = '';
                                _timesExpense.text = '';
                                _paymentExpense.text = '';
                                _notesExpense.text = '';
                                _categoryExpense.text = '';
                                double.parse(_expenseExpense.text);
                              }
                              ;
                            },
                            child: Text('Update'),
                          ),
                        ),
                         SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ElevatedButton(
                            onPressed: () async =>
                                showDialog(
                                context: context,
                                builder: (context)=>
                                    AlertDialog(
                                      title: Text('Delete'),
                                      content: Text('Do you want to delete this transaction record ?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context, rootNavigator: true).pop(false);
                                            },
                                            child: Text('No')),
                                        TextButton(
                                            onPressed: (){
                                              _deletee(documentSnapshot!.id);
                                              Navigator.of(context,rootNavigator: true).pop(true);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return const TransactionPage();
                                              }
                                              )
                                              );
                                            },
                                            child: Text('Yes'))
                                      ],
                                    )
                            ),
                              child: Text('Delete'),

                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30.0,
        backgroundColor: Colors.grey.shade100,
        title: Row(
          children: <Widget>[
            Container(
              width: 74,
              child: Text('Date',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 13)),
            ),
            Spacer(),
            Container(
              width: 74,
              child: Text('Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 13)),
            ),
            Spacer(),
            Container(
              width: 66,
              child: Text(
                'Income',
                style: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.normal,
                    fontSize: 13),
              ),
            ),
            Spacer(),
            Container(
              width: 66,
              child: Text(
                'Expense',
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.normal,
                    fontSize: 13),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: _addExpense.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
                  return StreamBuilder(
                      stream: _addIncome.snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (!streamSnapshot.hasData)
                          return const Center(child: Text('Loading...'));
                        if (!streamSnapshots.hasData)
                          return const Center(child: Text('Loading...'));
                        return Column(children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    borderOnForeground: true,
                                    shadowColor: Colors.cyan,
                                    child: ListTile(
                                      tileColor: Colors.grey.shade50,
                                      subtitle: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                  "${documentSnapshot.get('dates')}"
                                                  "\n${documentSnapshot.get('times')}"
                                                  "\n${documentSnapshot.get('notes')}"),
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                "${documentSnapshot.get('category')}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                "${documentSnapshot.get('income')}",
                                                style: TextStyle(
                                                    color:
                                                        Colors.green.shade900),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      trailing: Container(
                                        width: 75,
                                        child: Center(
                                          child: Text(""),
                                        ),
                                      ),
                                      onTap: () async {
                                        _update(documentSnapshot);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: streamSnapshots.data!.docs.length,
                              itemBuilder: (BuildContext context, index) {
                                final DocumentSnapshot documentSnapshot1 =
                                    streamSnapshots.data!.docs[index];
                                return Column(children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    borderOnForeground: true,
                                    shadowColor: Colors.cyan,
                                    child: ListTile(
                                      tileColor: Colors.grey.shade50,
                                      subtitle: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                  "${documentSnapshot1.get('dates')}"
                                                  "\n${documentSnapshot1.get('times')}"
                                                  "\n${documentSnapshot1.get('payment')}"
                                                  "\n${documentSnapshot1.get('notes')}"),
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                "${documentSnapshot1.get('category')}",
                                                style: TextStyle(
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 75,
                                            child: Center(
                                              child: Text(""),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: 75,
                                        child: Center(
                                          child: Text(
                                            "${documentSnapshot1.get('expense')}",
                                            style: TextStyle(
                                                color: Colors.red.shade900),
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        _updatee(documentSnapshot1);
                                      },
                                    ),
                                  )
                                ]);
                              }),
                        ]);
                      });
                },
              ),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Text("Total Transaction"),
                    Container(
                      height: 50,
                      width: 105,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //color of border
                            width: 1, //width of border
                          ),
                          borderRadius: BorderRadius.zero),
                      child: Column(
                        children: [
                          Text(
                            "Total Income  $totalIncome",
                            style: TextStyle(
                                fontSize: 16, color: Colors.green.shade900),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 105,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //color of border
                            width: 1, //width of border
                          ),
                          borderRadius: BorderRadius.zero),
                      child: Text(
                        "Total Expense  $totalExpense",
                        style:
                            TextStyle(fontSize: 16, color: Colors.red.shade900),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 108,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, //color of border
                            width: 1, //width of border
                          ),
                          borderRadius: BorderRadius.zero),
                      child: Text(
                        "Balance  \n${balance = totalIncome - totalExpense}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
