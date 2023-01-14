
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:expense_app/constants.dart';
import 'package:expense_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/expense_income.dart';
import 'category/service/ExpenseIncomeService.dart';
import 'others/empty_view.dart';

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
  bool isLoading = true;
  // late final CollectionReference
  // _addExpense= FirebaseFirestore.instance.collection('add_expense').orderBy('dates',descending: true);



  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getData().then((value) {
      setState(() {
        if(value != null) {
          expenseIncomeList = value;
          for (var element in value) {

            if(element.expense!=null){

              totalExpense += element.expense;
            }
            if(element.income != null){
              totalIncome += element.income;
            }
            balance=totalIncome-totalExpense;
          }
        }
        isLoading =false;
      });
    }) ;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
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
            const SizedBox(width: 20,height: 0,),
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
                        return const TransactionPage();
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
           // Divider(color: Colors.indigo.shade900,),
            Column(
              children: <Widget>[

                Divider(color: Colors.indigo.shade900,),
                //Text("ALL"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          style: const TextStyle(fontSize: 16,color: Colors.black,),
                          textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              Divider(color: Colors.indigo.shade900,),
              const SizedBox(height: 5,),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        height: 20,width: 150,
                        child: const Text('Recent Transactions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      ),
                      Spacer(),
                      Container(
                        height: 20,width: 150,
                        child: GestureDetector(
                          child: const Text("See All Transactions",style: TextStyle(color: kPrimaryColor,fontSize: 16),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const TransactionPage();
                            }
                            )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.indigo.shade900,),
                  SizedBox(
                    child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('add_expense').orderBy('times',descending: true).snapshots(),
                     builder:
                         (context, AsyncSnapshot<QuerySnapshot> streamSnapshots) {
                           if (!streamSnapshots.hasData) {
                             return const Center(child: Text('Loading...'));
                           }
                           return Column(
                             children: [
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
                                                 alignment: Alignment.centerLeft,
                                                 width: 75,
                                                 child: Text(
                                                     "${documentSnapshot1.get('dates')}"
                                                         "\n${documentSnapshot1.get('times')}"
                                                        // "\n${documentSnapshot1.get('payment')}"
                                                         //"\n${documentSnapshot1.get('notes')}"
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
                                                   child: Text("0.0",style: TextStyle(color: Colors.green)),
                                                 ),
                                               ),
                                             ],
                                           ),
                                           trailing: Container(
                                             width: 75,
                                             child: Center(
                                               child: Text(
                                                 "${documentSnapshot1.get('expense')} TK",
                                                 style: TextStyle(
                                                     color: Colors.red.shade900),
                                               ),
                                             ),
                                           ),
                                         ),
                                       )
                                     ]);
                                   }),
                             ],
                           );
                                 },
                  )
                  // SizedBox(
                  //   child: expenseIncomeList.isEmpty
                  //       ? SizedBox(
                  //     height: MediaQuery.of(context).size.height * 0.4,
                  //     child: const EmptyView(
                  //         icon: Icons.receipt_long,
                  //         label: 'No Transactions Found'),
                  //   )
                  //       : ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         itemCount:
                  //         expenseIncomeList.length > 5
                  //             ? expenseIncomeList.length
                  //             : 5,
                  //         itemBuilder: (context, index) {
                  //           return Column(
                  //             children: [
                  //               ListTile(
                  //                 tileColor: Colors.grey.shade50,
                  //                 subtitle: Row(
                  //                   children: <Widget>[
                  //                     Container(
                  //                       width: 75,
                  //                       child:  Center(
                  //                         child: Text(
                  //                             "${expenseIncomeList[index].dates}"
                  //                                 "\n${expenseIncomeList[index].times}"
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       width: 70,
                  //                       child: Center(
                  //                         child: Text(
                  //                           "${expenseIncomeList[index].category}",
                  //                           style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                  //                           textAlign: TextAlign.center,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       width: 75,
                  //                       child: Center(
                  //                         child: Text(
                  //                           "${expenseIncomeList[index].income}",
                  //                           style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.w400),
                  //                           textAlign: TextAlign.center,
                  //                         ),
                  //           a            ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 trailing: Container(
                  //                   width: 75,
                  //                   child: Center(
                  //                     child: Text(
                  //                       "${expenseIncomeList[index].expense}",
                  //                       style: TextStyle(color: Colors.red.shade900,fontWeight: FontWeight.w400),
                  //                       textAlign: TextAlign.center,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 // leading: Container(
                  //                 //   width: 75,
                  //                 //   child: Text(expenseIncomeList[index].category),
                  //                 // ),
                  //                 // title: Text(expenseIncomeList[index].dates),
                  //                 // subtitle: Text(expenseIncomeList[index].times),
                  //                 // trailing: Text("${expenseIncomeList[index].expense}"),
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               )
                  //             ],
                  //
                  //           );
                  //         }),
                   ),
                ],
              )
            ],
            ),
          ],
        ),
      ),
    );
  }
}

