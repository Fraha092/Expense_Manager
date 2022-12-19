
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/Budget/Budget_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../constants.dart';
import '../../../../models/expense_income.dart';
import '../../category/service/ExpenseIncomeService.dart';
import '../transaction_filter_page.dart';

class MonthlyTransaction extends StatefulWidget {
  const MonthlyTransaction({Key? key}) : super(key: key);

  @override
  State<MonthlyTransaction> createState() => _MonthlyTransactionState();
}
class _MonthlyTransactionState extends State<MonthlyTransaction> {

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // getCurrentUser(){
  //   final User? user =_auth.currentUser;
  //   final uid = user!.uid;
  //   //final uemail=user.email;
  //   print("uID $uid");
  //   return uid;
  // }
  // late String id='';

  DateTimeRange dateRange=DateTimeRange(
      start: DateTime(2022,12,01),
      end: DateTime(2022,12,31)
  );
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
   // id=getCurrentUser();
   // _addIncome= FirebaseFirestore.instance.collection(id).doc("add_income").collection(id);
  //  _addExpense = FirebaseFirestore.instance.collection(id).doc("add_expense").collection(id);
  }

  double totalExpense() {
    double totalExpense = 0;
    for (var element in expenseIncomeList) {
      totalExpense += element.expense ;
    }
    return totalExpense;
  }
  double totalIncome() {
    double totalIncome = 0;
    for (var element in expenseIncomeList) {
      totalIncome += element.income ;
    }
    return totalIncome;
  }

  loadData(){
    expenseIncomeList.clear();
    expenseIncomeService.getData().then((value) {
      if(mounted){
      setState(() {
        var dateFormat=DateFormat('yyyy-MM-dd');
        if(value!=null){
          for(var item in value){
            final mydate=dateFormat.parse(item.dates ?? '0');
            if(mydate.isBefore(dateRange.end) && mydate.isAfter(dateRange.start)){
              expenseIncomeList.add(item);
              print("myDate is between date1 and date2   ${dateRange.end}");
            }
            else{
              const Text('Transaction not Found');
            }
          }
        }
      });}
    }) ;
  }

  //
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
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //                 top: 20,
  //                 left: 20,
  //                 right: 20,
  //                 bottom: MediaQuery.of(context).viewInsets.bottom + 80),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text('Edit Transaction',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red.shade200),),
  //                           Spacer(),
  //                           Padding(
  //                             padding: const EdgeInsets.all(4.0),
  //                             child: IconButton(
  //                                 onPressed: () async =>
  //                                     showDialog(
  //                                         context: context,
  //                                         builder: (context)=>
  //                                             AlertDialog(
  //                                               title: Text('Delete'),
  //                                               content: Text('Do you want to delete this transaction record ?'),
  //                                               actions: <Widget>[
  //                                                 TextButton(
  //                                                     onPressed: (){
  //                                                       Navigator.of(context, rootNavigator: true).pop(false);
  //                                                     },
  //                                                     child: Text('No')),
  //                                                 TextButton(
  //                                                     onPressed: (){
  //                                                       _delete(documentSnapshot!.id);
  //                                                       Navigator.of(context,rootNavigator: true).pop(true);
  //                                                       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                                                         return const TransactionPage();
  //                                                       }
  //                                                       )
  //                                                       );
  //                                                     },
  //                                                     child: Text('Yes'))
  //                                               ],
  //                                             )
  //                                     ),
  //                                 icon: Icon(Icons.delete,color: Colors.red.shade300,size: 30,)),
  //                           )
  //                         ],
  //                       ),Divider(),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _datesIncome,
  //                           keyboardType: TextInputType.datetime,
  //                           decoration: InputDecoration(labelText: 'Dates',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.teal,
  //                           readOnly: true,
  //                           onTap: () async {
  //                             DateTime? pickedDate = await showDatePicker(
  //                                 context: context,
  //                                 initialDate: DateTime.now(),
  //                                 firstDate: DateTime(2000),
  //                                 lastDate: DateTime(2100));
  //                             if (pickedDate != null) {
  //                               setState(() {
  //                                 _datesIncome.text = DateFormat('yyyy-MM-dd')
  //                                     .format(pickedDate);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _timesIncome,
  //                           keyboardType: TextInputType.datetime,
  //                           decoration: InputDecoration(labelText: 'Times',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.teal,
  //                           readOnly: true,
  //                           onTap: () async {
  //                             var pickedTime = await showTimePicker(
  //                                 context: context,
  //                                 initialTime: TimeOfDay.now());
  //                             if (pickedTime != null) {
  //                               setState(() {
  //                                 _timesIncome.text =
  //                                     pickedTime.format(context);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _notesIncome,
  //                           keyboardType: TextInputType.text,
  //                           decoration: InputDecoration(labelText: 'Notes',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.teal,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _categoryIncome,
  //                           keyboardType: TextInputType.none,
  //                           decoration: InputDecoration(labelText: 'Category',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.teal,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _incomeIncome,
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(labelText: 'Income',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.teal,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 20,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 80),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.red.shade300
  //                           ),
  //                           onPressed: () async {
  //                             final String dates = _datesIncome.text;
  //                             final String times = _timesIncome.text;
  //                             final String notes = _notesIncome.text;
  //                             final String category = _categoryIncome.text;
  //                             final double income =
  //                             double.parse(_incomeIncome.text);
  //                             //final double? income=double.tryParse(_incomeIncome.text);
  //                             if (income != null) {
  //                               await _addIncome
  //                                   .doc(documentSnapshot!.id)
  //                                   .update({
  //                                 "dates": dates,
  //                                 "times": times,
  //                                 "notes": notes,
  //                                 "category": category,
  //                                 "income": income
  //                               });
  //                               _datesIncome.text = '';
  //                               _timesIncome.text = '';
  //                               _notesIncome.text = '';
  //                               _categoryIncome.text = '';
  //                               double.parse(_incomeIncome.text);
  //                             }
  //                             ;
  //                           },
  //                           child: Text('Update'),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
   }
  //  final CollectionReference _addExpense =
  //  FirebaseFirestore.instance.collection('add_expense');
  // final TextEditingController _datesExpense = TextEditingController();
  // final TextEditingController _timesExpense = TextEditingController();
  // final TextEditingController _paymentExpense = TextEditingController();
  // final TextEditingController _notesExpense = TextEditingController();
  // final TextEditingController _categoryExpense = TextEditingController();
  // final TextEditingController _expenseExpense = TextEditingController();
  //
  // Future<void> _deletee(String expenseId) async {
  //   await _addExpense.doc(expenseId).delete();
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('You have successfully deleted a Transaction')));
  //   //  Navigator.pop(context);
  // }
  //
  // Future<void> _updatee([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     _datesExpense.text = documentSnapshot['dates'].toString();
  //     _timesExpense.text = documentSnapshot['times'].toString();
  //     _notesExpense.text = documentSnapshot['notes'];
  //     _paymentExpense.text = documentSnapshot['payment'];
  //     _categoryExpense.text = documentSnapshot['category'];
  //     _expenseExpense.text = documentSnapshot['expense'].toString();
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("Updated!")));
  //   }
  //   await showModalBottomSheet(
  //       backgroundColor: Colors.grey.shade100,
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //                 top: 20,
  //                 left: 20,
  //                 right: 20,
  //                 bottom: MediaQuery.of(context).viewInsets.bottom + 80),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text('Edit Transaction',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red.shade200),),
  //                           Spacer(),
  //                           Padding(
  //                             padding: const EdgeInsets.all(4.0),
  //                             child: IconButton(
  //                                 onPressed: () async =>
  //                                     showDialog(
  //                                         context: context,
  //                                         builder: (context)=>
  //                                             AlertDialog(
  //                                               title: Text('Delete'),
  //                                               content: Text('Do you want to delete this transaction record ?'),
  //                                               actions: <Widget>[
  //                                                 TextButton(
  //                                                     onPressed: (){
  //                                                       Navigator.of(context, rootNavigator: true).pop(false);
  //                                                     },
  //                                                     child: Text('No')),
  //                                                 TextButton(
  //                                                     onPressed: (){
  //                                                       _deletee(documentSnapshot!.id);
  //                                                       Navigator.of(context,rootNavigator: true).pop(true);
  //                                                       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                                                         return const TransactionPage();
  //                                                       }
  //                                                       )
  //                                                       );
  //                                                     },
  //                                                     child: Text('Yes'))
  //                                               ],
  //                                             )
  //                                     ),
  //                                 icon: Icon(Icons.delete,color: Colors.red.shade300,size: 30,)),
  //                           )
  //                         ],
  //                       ),Divider(),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _datesExpense,
  //                           keyboardType: TextInputType.datetime,
  //                           decoration: InputDecoration(labelText: 'Dates',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                           readOnly: true,
  //                           onTap: () async {
  //                             DateTime? pickedDate = await showDatePicker(
  //                                 context: context,
  //                                 initialDate: DateTime.now(),
  //                                 firstDate: DateTime(2000),
  //                                 lastDate: DateTime(2100));
  //                             if (pickedDate != null) {
  //                               setState(() {
  //                                 _datesExpense.text = DateFormat('yyyy-MM-dd')
  //                                     .format(pickedDate);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _timesExpense,
  //                           keyboardType: TextInputType.datetime,
  //                           decoration: InputDecoration(labelText: 'Times',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                           readOnly: true,
  //                           onTap: () async {
  //                             var pickedTime = await showTimePicker(
  //                                 context: context,
  //                                 initialTime: TimeOfDay.now());
  //                             if (pickedTime != null) {
  //                               setState(() {
  //                                 _timesExpense.text =
  //                                     pickedTime.format(context);
  //                               });
  //                             }
  //                           },
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _paymentExpense,
  //                           keyboardType: TextInputType.none,
  //                           decoration:
  //                           InputDecoration(labelText: 'Payment Method',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _notesExpense,
  //                           keyboardType: TextInputType.text,
  //                           decoration: InputDecoration(labelText: 'Notes',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _categoryExpense,
  //                           keyboardType: TextInputType.none,
  //                           decoration: InputDecoration(labelText: 'Category',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.all(4.0),
  //                         child: TextField(
  //                           controller: _expenseExpense,
  //                           keyboardType: TextInputType.number,
  //                           decoration: InputDecoration(labelText: 'Expense',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
  //                           cursorColor: Colors.grey.shade200,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                         width: 20,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 80),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                               primary: Colors.red.shade300
  //                           ),
  //                           onPressed: () async {
  //                             final String dates = _datesExpense.text;
  //                             final String times = _timesExpense.text;
  //                             final String payment = _paymentExpense.text;
  //                             final String notes = _notesExpense.text;
  //                             final String category = _categoryExpense.text;
  //                             final double expense =
  //                             double.parse(_expenseExpense.text);
  //                             //final double? expense=double.tryParse(_expenseExpense.text);
  //                             if (expense != null) {
  //                               await _addExpense
  //                                   .doc(documentSnapshot!.id)
  //                                   .update({
  //                                 "dates": dates,
  //                                 "times": times,
  //                                 "payment": payment,
  //                                 "notes": notes,
  //                                 "category": category,
  //                                 "expense": expense
  //                               });
  //                               _datesExpense.text = '';
  //                               _timesExpense.text = '';
  //                               _paymentExpense.text = '';
  //                               _notesExpense.text = '';
  //                               _categoryExpense.text = '';
  //                               double.parse(_expenseExpense.text);
  //                             }
  //                             ;
  //                           },
  //                           child: Text('Update'),
  //                         ),
  //                       ),
  //                       SizedBox(height: 10,),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    final start=dateRange.start;
    final end=dateRange.end;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 68.0,
        //leadingWidth: 200,
        backgroundColor: Colors.grey.shade100,
        title: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(width: 74,
                      child: Center(child: const Text('Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13)))),
                  const Spacer(),
                  Container(width: 74,
                      child: const Text('Category',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13))),
                  const Spacer(),
                  Container(width: 66,
                      child: Text('Income',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.normal,fontSize: 13),)),
                  const Spacer(),
                  Container(width: 66,
                      child: Text('Expense',style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.normal,fontSize: 13),)),
                ],
              ),
              const Divider(thickness: 1.3,),
            //  Divider(),
              SizedBox(
                height: 30,width: 380,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: pickDateRange,
                        child: Text(
                          'From: ${start.year}-${start.month}-${start.day}',
                          style: TextStyle(color: Colors.cyan.shade900),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextButton(
                        onPressed: pickDateRange,
                        child: Text(
                            'To: ${end.year}-${end.month}-${end.day}',
                          style: TextStyle(color: Colors.cyan.shade900),

                        ),
                      ),
                    ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 20),
                      //   child: IconButton(
                      //       icon: Icon(Icons.picture_as_pdf_rounded,color: Colors.black,),
                      //       // onPressed: () => generateReport(PdfPageFormat(200,300), CustomData(name: "value")),
                      //       onPressed: () => download(),
                      //   ),
                      // ),
                      SizedBox(
                        width: 10,
                      ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: expenseIncomeList.length,
                  itemBuilder: (BuildContext ctx, index){
                    return Card(
                      borderOnForeground: true,
                      shadowColor: Colors.cyan,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          GestureDetector(
                            child: ListTile(
                              tileColor: Colors.grey.shade50,
                              subtitle: Row(
                                children: <Widget>[
                                  Container(
                                    width: 75,
                                    child:  Center(
                                      child: Text(
                                          "${expenseIncomeList[index].dates}"
                                              "\n${expenseIncomeList[index].times}"
                                              "\n${expenseIncomeList[index].payment ?? ""}"
                                              "\n${expenseIncomeList[index].notes}"
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 75,
                                    child: Center(
                                      child: Text(
                                        "${expenseIncomeList[index].category}",
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 75,
                                    child: Center(
                                      child: Text(
                                        "${expenseIncomeList[index].income}",
                                        style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              trailing: Container(
                                width: 75,
                                child: Center(
                                  child: Text(
                                      "${expenseIncomeList[index].expense}",
                                    style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                               // onTap: () async {
                               //   _update(expenseIncomeList);
                               // },
                            ),
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context){
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
                                                Row(
                                                  children: [
                                                    Text('Edit Transaction',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red.shade200),),
                                                    Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: IconButton(
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
                                                                                //_delete(expenseIncomeList);
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
                                                          icon: Icon(Icons.delete,color: Colors.red.shade300,size: 30,)),
                                                    )
                                                  ],
                                                ),Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: TextField(
                                                    controller: _datesIncome,
                                                    keyboardType: TextInputType.datetime,
                                                    decoration: InputDecoration(labelText: 'Dates',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
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
                                                    decoration: InputDecoration(labelText: 'Times',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
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
                                                    decoration: InputDecoration(labelText: 'Notes',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
                                                    cursorColor: Colors.teal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: TextField(
                                                    controller: _categoryIncome,
                                                    keyboardType: TextInputType.none,
                                                    decoration: InputDecoration(labelText: 'Category',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
                                                    cursorColor: Colors.teal,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: TextField(
                                                    controller: _incomeIncome,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(labelText: 'Income',floatingLabelAlignment: FloatingLabelAlignment.center,fillColor: Colors.red.shade50),
                                                    cursorColor: Colors.teal,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 80),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.red.shade300
                                                    ),
                                                    onPressed: () async {
                                                      final String dates = _datesIncome.text;
                                                      final String times = _timesIncome.text;
                                                      final String notes = _notesIncome.text;
                                                      final String category = _categoryIncome.text;
                                                      final double income =
                                                      double.parse(_incomeIncome.text);
                                                      //final double? income=double.tryParse(_incomeIncome.text);
                                                      if (income != null) {
                                                        // await _addIncome
                                                        //     .doc(expenseIncomeList[index])
                                                        //     .update({
                                                        //   "dates": dates,
                                                        //   "times": times,
                                                        //   "notes": notes,
                                                        //   "category": category,
                                                        //   "income": income
                                                        // });
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
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                                }
                              );
                            },
                          ),

                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
          Expanded(flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Container(
                        height:80,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Column(
                          children: [
                            Text("Total Monthly Income  \n${totalIncome()}",
                              style: TextStyle(fontSize: 16,color: Colors.green.shade900),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Container(
                        height:80,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Total Monthly Expense  \n${totalExpense()}",
                          style: TextStyle(fontSize: 16,color: Colors.red.shade900),
                          textAlign: TextAlign.center,),
                      ),
                      Container(
                        height:80,
                        width:108,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Monthly Balance  \n${totalIncome()-totalExpense()}",
                          style: const TextStyle(fontSize: 16,color: Colors.black,),
                          textAlign: TextAlign.center,),
                      ),

                    ],
                  ),
                ),
              ))
        ],

      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        onPressed: () =>download(),
        child: Icon(Icons.picture_as_pdf_rounded),
      ),
    );
  }
  Future pickDateRange() async{
    DateTimeRange? newDateRange=await
    showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.utc(2015),
      lastDate: DateTime.utc(2025),
    );
    if(newDateRange!=null) {
        setState(() {
        dateRange = newDateRange;
        loadData();
      });
    }
  }
  Future<void> download() async {
    final pdf = pw.Document();
    var data = await rootBundle.load("assets/font/OpenSans-Regular.ttf");
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context )=>[
            pw.Header(text: 'Monthly Transaction\n\n\n',),
            pw.Center(
              child: pw.Text('Date ${dateRange}'),

            ),
            pw.Divider(),
            pw.Center(
            //pw.Text('expenseIncomeList ${expenseIncomeList.first.expense}'),
            child: pw.Table.fromTextArray(
                context: context, data: <List<String>>[
              <String>[
                'Date',
                'Category',
                'Payment Method',
                'Notes',
                'Income',
                'Expense'
              ],
              ...expenseIncomeList.map((item) =>
              [
                item.dates,
                item.category,
                item.payment,
                item.notes,
                item.income.toString(),
                item.expense.toString()
              ],),
            ],
            ),
            ),
            pw.Divider(),
            pw.Table(
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Total Income ${totalIncome()}\n'),
                          pw.Text('Total Expense ${totalExpense()}\n'),
                          pw.Text('Balance  ${totalIncome()-totalExpense()}\n'),
                        ]
                      )
                    )
                  ]
                )
              ]
            ),
          ],
      ),
    );
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final String path = '$directory/Monthly_Transaction.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    print("file   $file");
  }

}
