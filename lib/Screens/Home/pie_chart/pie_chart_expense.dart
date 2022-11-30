
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Expense_pieChart_component/All_pie_chart_expense.dart';
import 'Expense_pieChart_component/Monthly_pie_chart_expense.dart';
import 'Expense_pieChart_component/Yearly_pie_chart_expense.dart';



class PieChartExpense extends StatefulWidget {
  const PieChartExpense({Key? key}) : super(key: key);

  @override
  State<PieChartExpense> createState() => _PieChartExpenseState();
}

class _PieChartExpenseState extends State<PieChartExpense> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 1.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade100,
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  child: Container(

                    child: const Text(
                      'All',
                      style: TextStyle(fontSize: 11.0,color: Colors.black),
                    ),
                  ),
                ),

                Tab(
                  child: Container(
                    child: Text(
                      'Monthly',
                      style: TextStyle(fontSize: 11.0,color: Colors.black),
                    ),
                  ),
                ),
                Tab(
                  child: Container(

                    child: Text(
                      'Yearly',
                      style: TextStyle(fontSize: 11.0,color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              AllExpensePieChart(),
              MonthlyExpensePieChart(),
              YearlyExpensePieChart(),
            ],
          ),
        )
    );

  }
}





