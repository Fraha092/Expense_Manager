
import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/expense_income.dart';
import 'category/service/ExpenseIncomeService.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double totalIncome = 0;
  double totalExpense=0;
  double balance=0;

  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getData().then((value) {
      setState(() {
        if(value != null) {
          expenseIncomeList = value;
          for (var element in value) {
            if(element.expense!=null){
              totalExpense += element.expense ?? 0;
            }
            if(element.income != null){
              totalIncome += element.income ?? 0;
            }
            balance=totalIncome-totalExpense;
          }
        }

      });
    }) ;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10.0),
      //height: 150,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
            children: [
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                Expanded(flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.teal.shade50,
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddExpensePage(category: Cat(id: 0, name: "", icon: 0),);
                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(Icons.money_off,color: Color(0xFF1B5E20),size: 50,),
                          ),
                          Center(child: Text('Add Expense',
                            style: TextStyle(color: Color(0xFF1B5E20),
                                fontSize: 20),))
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(width: 10,height: 0,),
              Expanded(flex: 1,
                  child: Container(
                    //  height: MediaQuery.of(context).size.height*0.70,
                    // width: MediaQuery.of(context).size.width*0.25,
                    decoration: BoxDecoration(color: Colors.teal.shade50,
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              //return AddIncomePage(categoryTitle: '');
                              return AddIncomePage(category: IncomeCat(id: 0, name: "", icon: 0),);

                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(Icons.add,color: Color(0xFFB71C1C),size: 50,),
                        ),
                          Center(child: Text('Add Income',
                            style: TextStyle(color: Color(0xFFB71C1C),
                                fontSize: 20),),)
                        ],
                      ),
                    ),
                  )
              )
            ],
            ),
            SizedBox(width: 20,height: 0,),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.teal.shade50,
                border: Border.all(
                  color: Colors.black, //color of border
                  width: 1, ),
                borderRadius: BorderRadius.circular(10.0),),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return TransactionPage();
                      })
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.toc,color:  Color(0xFF1A237E),size: 50,),
                  ),
                    Center(child: Text('Transaction',
                      style: TextStyle(color: Color(0xFF1A237E),
                          fontSize: 20),),)
                  ],
                ),
              ),
            ),
            ),
            Divider(color: Colors.indigo.shade900,),
            Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            Text("Total Income  $totalIncome",
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
                        child: Text("Total Expense  $totalExpense",
                          style: TextStyle(fontSize: 16,color: Colors.red.shade900),
                          textAlign: TextAlign.center,),
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
                        child: Text("Balance  \n$balance",
                          style: TextStyle(fontSize: 16,color: Colors.black,),
                          textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:45,
                        width:350,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: Center(child: Text('Previous Balance',style: TextStyle(color: Colors.black,fontSize: 16),)),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:45,
                        width:350,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 1, //width of border
                            ),
                            borderRadius: BorderRadius.zero
                        ),
                        child: const Center(child: Text('Balance',style: TextStyle(color: Colors.black,fontSize: 16),)),
                      ),
                    ),
              ],
            ),
            ),
              Divider(color: Colors.indigo.shade900,),
            ],
            ),
          ],
        ),
      ),
    );
  }
}

