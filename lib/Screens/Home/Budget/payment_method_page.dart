// //import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../models/category.dart';
// import '../../../models/expense_income.dart';
// class PaymentMethodPage extends StatefulWidget {
//   const PaymentMethodPage({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentMethodPage> createState() => _PaymentMethodPageState();
// }
// enum Move_month{previous, Next}
//
// class _PaymentMethodPageState extends State<PaymentMethodPage> {
//   DateTime _currentDate = DateTime.now();
//   bool _controlCombined = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     ExpenseIncome _expenseincomeProvider=Provider.of<ExpenseIncome>(context);
//
//     return AspectRatio(
//         aspectRatio: 1,
//       child: Card(
//         child: FutureBuilder(
//           future: _monthlyExpenses(
//             _expenseincomeProvider.getExpenseData(_controlCombined),
//               _currentDate.month,_currentDate.year
//           ),
//           builder: (ctx, _expenseSnap){
//             if(_expenseSnap.connectionState==ConnectionState.waiting)
//               return CircularProgressIndicator();
//             List<ExpenseIncome>?_expensesToBuildGraph=_expenseSnap.data;
//             List<Cat>_categoriesToBuildGraph= ExpenseIncome.()
//           },
//         ),
//       ),
//     );
//   }
// }
// Future<List<ExpenseIncome>> _monthlyExpenses(
//     Future<List<ExpenseIncome>> _allExpenses, int month, int year) async {
//   List<ExpenseIncome> _allExpensesDone = await _allExpenses;
//
//   _allExpensesDone
//       .removeWhere((_e) => _e.when.month != month || _e.when.year != year);
//
//   return _allExpensesDone;
// }
