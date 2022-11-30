import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:get/get.dart';

import '../../../../models/expense_income.dart';
import '../../category/service/ExpenseIncomeService.dart';

class AllIncomePieChart extends StatefulWidget {
  const AllIncomePieChart({Key? key}) : super(key: key);

  @override
  State<AllIncomePieChart> createState() => _AllIncomePieChartState();
}

class _AllIncomePieChartState extends State<AllIncomePieChart> {
  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;
  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];

  int key = 0;

  @override
  void initState() {
    // TODO: implement initState
    expenseIncomeService.getIncomeData().then((value) {
      setState(() {
        if (value != null) {
          for (var listItem in value) {
            expenseIncomeList.addExpenseIncome(expenseIncome: listItem);
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

  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in expenseIncomeList) {
      if (catMap.containsKey(item.category) == false) {
        catMap[item.category.toString()] = item.income;
      } else {
        double sum = 0;
        if (catMap.containsKey(item.category)) {
          double beforeValue = catMap[item.category] ?? 0;
          sum = beforeValue + (item.income);
          catMap.update(item.category.toString(), (double) => sum);
        }
      }
    }
    return catMap;
  }

  List<Color> colorList = [
    Color.fromRGBO(75, 135, 185, 1),
    Color.fromRGBO(192, 108, 132, 1),
    Color.fromRGBO(246, 114, 128, 1),
    Color.fromARGB(255, 245, 156, 120),
    Color.fromRGBO(116, 180, 155, 1),
    Color.fromRGBO(0, 168, 181, 1),
  ];

  Widget pieChartOne() {
    return PieChart(
      key: ValueKey(key),
      dataMap: getCategoryData(),
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 800),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 2.4,
      ringStrokeWidth: 36,
      colorList: colorList,
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: false,
          showChartValues: true,
          decimalPlaces: 2,
          chartValueStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      centerText: 'Income \n${expenseIncomeService.totalIncome} ',
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        // legendLabels:  {},
        legendShape: BoxShape.circle,
        legendPosition: LegendPosition.right,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        if (getCategoryData().isNotEmpty) ...[
          Card(
            child: SizedBox(height: 280, child: pieChartOne()),
          ),
        ] else ...[
          Center(
            child: Column(
              children: [Icon(Icons.refresh_sharp), Text("Loading...")],
            ),
          ),
        ],
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 90,
                  child: Text('Category',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  alignment: Alignment.centerRight,
                ),
                Spacer(),
                Container(
                  width: 75,
                  child: Text(
                    'Amount',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  alignment: Alignment.centerRight,
                ),
                //Spacer(),
                Container(
                  width: 85,
                  child: Text('%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  alignment: Alignment.centerRight,
                ),
                Spacer(),
              ],
            ),
          ],
        ),
        Divider(),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: expenseIncomeList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Column(
                    children: <Widget>[
                      //ListTile(
                      // subtitle:
                      Row(
                        children: <Widget>[
                          Container(
                            width: 120,
                            child: Center(
                              child: Text(
                                "${expenseIncomeList[index].category}",
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                            width: 100,
                            child: Center(
                              child: Text(
                                "${expenseIncomeList[index].income}",
                                style: TextStyle(
                                    color: Colors.green.shade900, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                            width: 85,
                            child: Center(
                              child: Text(
                                "${categoryPercent(expenseIncomeList[index].income, expenseIncomeService.totalIncome).toStringAsFixed(2)} %",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Divider()
                    ],
                  );
                }),
          ),
        ),
        BottomAppBar(
          notchMargin: 8.0,
          // shape: NotchedShape(),
          child: Text(
            "Total Income  ${expenseIncomeService.totalIncome}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900),
          ),
        ),
      ],
    ));
  }
}

double categoryPercent(
  double income,
  double totalIncome,
) {
  double percent = (income / totalIncome) * 100.floor();
  return percent;
}

extension on List<ExpenseIncome> {
  void addExpenseIncome({required ExpenseIncome expenseIncome}) {
    print("expenses 3 ${expenseIncome.category}    ${expenseIncome.toMap()}");

    var incomes = 0.0;
    if (isNotEmpty) {
      try {
        var income = firstWhere((p) => p.category == expenseIncome.category);
        print("expenses 1 $incomes");
        income.income += (expenseIncome.income ?? 0);

        print("expenses 2 $incomes ${income.income ?? "0"}");
        //person.expense == expenses;
      } catch (e) {
        add(ExpenseIncome(
            expense: expenseIncome.expense,
            income: expenseIncome.income,
            category: expenseIncome.category,
            payment: expenseIncome.payment,
            dates: expenseIncome.dates,
            times: expenseIncome.times,
            notes: expenseIncome.notes));
      }
    } else {
      print("expenses 4 $incomes ${expenseIncome.category ?? "0"}");

      add(ExpenseIncome(
          expense: expenseIncome.expense,
          income: expenseIncome.income,
          category: expenseIncome.category,
          payment: expenseIncome.payment,
          dates: expenseIncome.dates,
          times: expenseIncome.times,
          notes: expenseIncome.notes));
    }
  }
}
