import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/expense_income.dart';
import '../../category/service/ExpenseIncomeService.dart';

class YearlyTransaction extends StatefulWidget {

  const YearlyTransaction({Key? key, }) : super(key: key);

  @override
  State<YearlyTransaction> createState() => _YearlyTransactionState();
}

class _YearlyTransactionState extends State<YearlyTransaction> {
  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  DateTimeRange dateRange=DateTimeRange(
      start: DateTime(2022,01,01),
      end: DateTime(2022,12,31)
  );
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  double totalExpenses(){
    double totalExpense = 0;
    for (var element in expenseIncomeList) {
      totalExpense += element.expense ;
    }
    return totalExpense;
  }
  double totalIncomes(){
    double totalIncome = 0;
    for (var element in expenseIncomeList) {
      totalIncome += element.income ;
    }
    return totalIncome;
  }
  // double totalBalances(){
  //   double totalBalance = 0;
  //   for (var element in expenseIncomeList) {
  //     totalBalance = totalIncomes()-totalExpenses() ;
  //   }
  //   return totalBalance;
  // }

  loadData(){
    expenseIncomeList.clear();
    expenseIncomeService.getData().then((value) {
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
      });
    }) ;
  }
  @override
  Widget build(BuildContext context) {

    final start=dateRange.start;
    final end=dateRange.end;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70.0,
        backgroundColor: Colors.grey.shade100,
        title: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    child: Text('Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13)),
                  ),
                  Spacer(),
                  Container(
                    child: Text('Category',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13)),
                  ),
                  Spacer(),
                  Container(
                    child: Text('Income',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.normal,fontSize: 13),),
                  ),
                  Spacer(),
                  Container(child: Text('Expense',style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.normal,fontSize: 13),),),
                ],
              ),
              Divider(thickness: 1.3,),
              //  Divider(),
              SizedBox(
                height: 30,width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                        child: Text(
                          'From: ${start.year}-${start.month}-${start.day}',
                          style: TextStyle(color: Colors.cyan.shade900),

                        ),
                        onPressed: pickDateRange,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextButton(
                        child: Text(
                            'To: ${end.year}-${end.month}-${end.day}',
                          style: TextStyle(color: Colors.cyan.shade900),
                        ),
                        onPressed: pickDateRange,
                      ),
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
                  physics: ScrollPhysics(),
                  itemCount: expenseIncomeList.length,
                  itemBuilder: (BuildContext ctx, index){
                    return Card(
                      borderOnForeground: true,
                      shadowColor: Colors.cyan,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          ListTile(
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
                                      style: const TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  child: Center(
                                    child: Text(
                                      "${expenseIncomeList[index].income ?? ""}",
                                      style: TextStyle(color: Colors.green.shade900),
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
                                    "${expenseIncomeList[index].expense?? " "}"
                                ),
                              ),
                            ),
                            // onTap: () async {
                            //   _update(documentSnapshot);
                            // },
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
                        height:50,
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
                            Text("Total Income  ${totalIncomes()}",
                              style: TextStyle(fontSize: 16,color: Colors.green.shade900),
                              textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      Container(
                        height:50,
                        width:105,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Total Expense  ${totalExpenses()}",
                          style: TextStyle(fontSize: 16,color: Colors.red.shade900),
                          textAlign: TextAlign.center,),
                      ),
                      Container(
                        height:50,
                        width:108,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Text("Balance  \n${totalIncomes()-totalExpenses()}",
                          style: const TextStyle(fontSize: 16,color: Colors.black,),
                          textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ))
        ],
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
}
