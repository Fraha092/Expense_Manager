
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../models/expense_income.dart';
import '../../category/service/ExpenseIncomeService.dart';

class MonthlyIncomePieChart extends StatefulWidget {
  const MonthlyIncomePieChart({Key? key}) : super(key: key);

  @override
  State<MonthlyIncomePieChart> createState() => _MonthlyIncomePieChartState();
}

class _MonthlyIncomePieChartState extends State<MonthlyIncomePieChart> {

  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;
  ExpenseIncomeService expenseIncomeService = ExpenseIncomeService();
  List<ExpenseIncome> expenseIncomeList = [];
  List<ExpenseIncome> expenseIncomeList2 = [];

  DateTimeRange dateRange=DateTimeRange(
      start: DateTime(2022,12,01),
      end: DateTime(2022,12,31)
  );

  int key=0;

  @override
  void initState() {
    //loadData();
    expenseIncomeList2.clear();
    expenseIncomeService.getIncomeData().then((value) {
      setState(() {
        if(value != null) {
          for(var listItem in value){
            expenseIncomeList2.addExpenseIncome(expenseIncome: listItem);
          }
        }
        loadDataMonthWise();
      });
    }) ;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  double totalChartIncome() {
    double totalIncome = 0;
    for (var element in expenseIncomeList) {
      totalIncome += element.income ;
    }
    return totalIncome;
  }

  loadDataMonthWise(){
    expenseIncomeList.clear();
    var dateFormat = DateFormat('yyyy-MM-dd');
          if(expenseIncomeList2!=null) {
            for (var item in expenseIncomeList2) {
              final mydate = dateFormat.parse(item.dates ?? '0');
              if (mydate.isBefore(dateRange.end) &&
                  mydate.isAfter(dateRange.start)) {
                expenseIncomeList.add(item);
              }
              else {
                const Text('Transaction not Found');
              }
            }
          }
  }

  Map<String, double> getCategoryData(){
    Map<String,double>catMap={};
    for(var item in expenseIncomeList){
      //  print("catMap cat ${item.category}:${item.expense}");
      if(catMap.containsKey(item.category)==false){
        catMap[item.category.toString()] =  item.income;
      }
      else{
        double sum = 0;
        if(catMap.containsKey(item.category)){
          double beforeValue = catMap[item.category] ?? 0;
          sum = beforeValue + (item.income);
          // print("catMap sum ${item.category}  $beforeValue ${catMap[item.category] ?? 0}    ${double.parse(item.expense ?? "0")}   $sum");
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

  Widget pieChartOne(){
    return PieChart(
      key: ValueKey(key),
      dataMap: getCategoryData(),
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 800),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width/2.4,
      ringStrokeWidth: 36,
      colorList: colorList,
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: false,
          showChartValues: true,
          decimalPlaces: 2,
          chartValueStyle: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black)),
      centerText: 'Income \n${totalChartIncome()} ',
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        // legendLabels:  {},
        legendShape: BoxShape.circle,
        legendPosition: LegendPosition.right,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.normal,fontSize: 12,
          color: Colors.black,

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final start=dateRange.start;
    final end=dateRange.end;
    return Scaffold(
        body: Column(
          children: <Widget>[
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
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: pickDateRange,
                      child: Text(
                          'To: ${end.year}-${end.month}-${end.day}',
                        style: TextStyle(color: Colors.cyan.shade900),
                      ),

                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1.3,),
            SizedBox(
              width: 10,
            ),
            if(getCategoryData().isNotEmpty)...[
              Card(
                child: SizedBox(
                    height: 280,
                    child: pieChartOne()),
              ),
            ]else...[
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.refresh_sharp),
                    Text("Loading..."),
                  ],
                ),
              )
            ],
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  <Widget>[
                    Container(
                      width: 90,
                      alignment: Alignment.centerRight,
                      child: const Text('Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),),
                    const Spacer(),
                    Container(
                      width: 75,
                      alignment: Alignment.centerRight,
                      child: const Text('Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    ),
                    //Spacer(),
                    Container(
                      width: 85,
                      alignment: Alignment.centerRight,
                      child: const Text('%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
            const Divider(),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: expenseIncomeList.length,
                    itemBuilder: (BuildContext ctx, index){
                      return Column(
                        children: <Widget>[
                          //ListTile(
                          // subtitle:
                          Row(
                            children: <Widget>[
                              Container(width: 120,
                                child: Center(
                                  child: Text(
                                    "${expenseIncomeList[index].category}",
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),const Spacer(flex: 1,),
                              Container(width: 100,
                                child: Center(
                                  child: Text(
                                    "${expenseIncomeList[index].income}",
                                    style: TextStyle(color: Colors.green.shade900,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),const Spacer(flex: 1,),
                              Container(width: 85,
                                child: Center(
                                  child: Text("${categoryPercent(expenseIncomeList[index].income,
                                      totalChartIncome()).toStringAsFixed(2)} %",
                                    style: const TextStyle(color: Colors.black,fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),const Spacer(),

                            ],
                          ),
                          Divider()
                        ],
                      );
                    }
                ),
              ),
            ),
            BottomAppBar(
              notchMargin: 8.0,
              // shape: NotchedShape(),
              child: Text("Total Income  ${totalChartIncome()}",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red.shade900),),
            ),

          ],
        )

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
        loadDataMonthWise();
      });
    }
  }
}
double categoryPercent(double income, double totalIncome,){

  double percent =  (income/totalIncome)*100.floor();
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
        income.income += (expenseIncome.income);

        print("expenses 2 $incomes ${income.income}");
        //person.expense == expenses;
      } catch(e) {
        add(ExpenseIncome(expense: expenseIncome.expense, income: expenseIncome.income, category: expenseIncome.category, payment: expenseIncome.payment, dates: expenseIncome.dates, times: expenseIncome.times, notes: expenseIncome.notes));
      }
    } else {
      print("expenses 4 $incomes ${expenseIncome.category}");

      add(ExpenseIncome( expense: expenseIncome.expense, income: expenseIncome.income, category: expenseIncome.category, payment: expenseIncome.payment, dates: expenseIncome.dates, times: expenseIncome.times, notes: expenseIncome.notes));
    }
  }
}