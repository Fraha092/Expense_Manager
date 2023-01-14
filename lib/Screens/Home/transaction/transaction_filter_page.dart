import 'package:expense_app/Screens/Home/transaction/components/all_transaction.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/monthly_transaction.dart';
import 'components/yearly_transaction.dart';
class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}
class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Row(
              children: const [
                Text('Transactions',style: TextStyle(fontSize: 20.0),),
                Spacer(),
              ],
            ),
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: kPrimaryColor,
              indicatorWeight: 3,
              labelColor: kPrimaryColor,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: const Text(
                      'All',
                      style: TextStyle(fontSize: 11.0,color: Colors.white),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: const Text(
                      'Monthly',
                      style: TextStyle(fontSize: 11.0,color: Colors.white),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: const Text(
                      'Yearly',
                      style: TextStyle(fontSize: 11.0,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body:  const TabBarView(
            children: <Widget>[
              AllTransaction(),
              MonthlyTransaction(),
              YearlyTransaction(),
            ],
          ),
        ),
    );
  }
}
