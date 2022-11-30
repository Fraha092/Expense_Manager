import 'package:expense_app/Screens/Home/pie_chart/pie_chart_expense.dart';
import 'package:expense_app/Screens/Home/pie_chart/pie_chart_income.dart';
import 'package:expense_app/Screens/Home/pie_chart/pie_chart_income0.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryChartPage extends StatelessWidget {
  const CategoryChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text('Charts',style: TextStyle(fontSize: 20)),
            bottom: TabBar(
             // physics: ScrollPhysics(),
                isScrollable: false,
                indicatorColor: Colors.teal,
                indicatorWeight: 3,
                labelColor: Colors.teal,
                tabs: <Widget>[
                  Tab(
                    child: Container(
                      child: Text(
                        'EXPENSE',
                        style: TextStyle(color: Colors.white,fontSize: 18.0),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text(
                        'INCOME',
                        style: TextStyle(color: Colors.white,fontSize: 18.0),
                      ),
                    ),
                  ),
                ]
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              PieChartExpense(),
               //SizedBox(height: 30,),
               PieChartIncome()

            ],
          ),
        )
    );
  }
}
