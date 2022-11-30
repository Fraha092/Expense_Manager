
import 'package:flutter/material.dart';

import 'Income_pieChart_component/All_pie_chart_Income.dart';
import 'Income_pieChart_component/Monthly_pie_chart_Income.dart';
import 'Income_pieChart_component/Yearly_pie_chart_Income.dart';


class PieChartIncome extends StatefulWidget {
  const PieChartIncome({Key? key}) : super(key: key);

  @override
  State<PieChartIncome> createState() => _PieChartIncomeState();
}

class _PieChartIncomeState extends State<PieChartIncome> {

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
                    child: const Text(
                      'Monthly',
                      style: TextStyle(fontSize: 11.0,color: Colors.black),
                    ),
                  ),
                ),
                Tab(
                  child: Container(

                    child: const Text(
                      'Yearly',
                      style: TextStyle(fontSize: 11.0,color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              AllIncomePieChart(),
              MonthlyIncomePieChart(),
               YearlyIncomePieChart(),
            ],
          ),
        )
    );

  }
}





