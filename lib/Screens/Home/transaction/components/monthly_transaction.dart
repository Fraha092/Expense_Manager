
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/expense_income.dart';
import '../../category/service/ExpenseIncomeService.dart';

class MonthlyTransaction extends StatefulWidget {
  const MonthlyTransaction({Key? key}) : super(key: key);

  @override
  State<MonthlyTransaction> createState() => _MonthlyTransactionState();
}
class _MonthlyTransactionState extends State<MonthlyTransaction> {

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  DateTimeRange dateRange=DateTimeRange(
      start: DateTime(2022,11,01),
      end: DateTime(2022,11,30)
  );
  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
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
  double totalBalance() {
    double totalBalance = 0;
    for (var element in expenseIncomeList) {
      totalBalance = totalIncome()-totalExpense() ;
    }
    return totalBalance;
  }

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
        toolbarHeight: 68.0,
        //leadingWidth: 200,
        backgroundColor: Colors.grey.shade100,
        title: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13)),
                  const Spacer(),
                  const Text('Category',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13)),
                  const Spacer(),
                  Text('Income',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.normal,fontSize: 13),),
                  const Spacer(),
                  Text('Expense',style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.normal,fontSize: 13),),
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
                    )
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
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  child: Center(
                                    child: Text(
                                      "${expenseIncomeList[index].income}",
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
                                    "${expenseIncomeList[index].expense}"
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
                            Text("Total Income  ${totalIncome()}",
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
                        child: Text("Total Expense  ${totalExpense()}",
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
                        child: Text("Balance  \n${totalBalance()}",
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
