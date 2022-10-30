
import 'package:expense_app/Screens/Home/expense/add_expense_page.dart';
import 'package:expense_app/Screens/Home/income/add_income_page.dart';
import 'package:expense_app/Screens/Home/transaction/transaction_filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10.0),
      //height: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddExpensePage(categoryTitle: '',);
                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                       children: const [
                         CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 30,
                              child: Icon(Icons.money_off,color: Colors.teal,size: 50,),
                       ),
                         Center(child: Text('Add Expense',
                           style: TextStyle(color: Colors.white,
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
                    decoration: BoxDecoration(color: Colors.teal.shade200,
                      borderRadius: BorderRadius.circular(10.0),),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return AddIncomePage(categoryTitle: '');
                            })
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 30,
                          child: Icon(Icons.add,color: Colors.teal,size: 50,),
                        ),
                          Center(child: Text('Add Income',
                            style: TextStyle(color: Colors.white,
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
              decoration: BoxDecoration(color: Colors.teal.shade200,
                borderRadius: BorderRadius.circular(10.0),),
              child: TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return TransactionFilterPage();
                        })
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: 30,
                      child: Icon(Icons.toc,color: Colors.teal,size: 50,),
                    ),
                      Center(child: Text('Transaction',
                        style: TextStyle(color: Colors.white,
                            fontSize: 20),),)
                    ],
                  ),),
            ),
          )
        ],
      ),
    );
  }
}

