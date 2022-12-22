
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_app/models/expense_income.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseIncomeService {
   final CollectionReference _addExpense =
  FirebaseFirestore.instance.collection('add_expense');
   final CollectionReference _addIncome =
  FirebaseFirestore.instance.collection('add_income');

   final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // getCurrentUser(){
  //   final User? user =_auth.currentUser;
  //   final uid = user!.uid;
  //   //final uemail=user.email;
  //   print("uID $uid");
  //   return uid;
  // }
  //
  //
  // late String id='';
  //
  // void initState(){
  //   //super.initState();
  //   id = getCurrentUser();
  //   _addIncome = FirebaseFirestore.instance.collection(id).doc("add_income").collection(id);
  //   _addExpense = FirebaseFirestore.instance.collection(id).doc("add_expense").collection(id);
  //
  // }

  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;
  double total = 0;

  Future<List<ExpenseIncome>?> getData() async {
    totalIncome = 0;
    totalExpense =0;
    balance = 0;
    List<ExpenseIncome> expenseIncomeList = [];
    // for expense
    QuerySnapshot addExpenseQuerySnapshot = await _addExpense.get();
    final List<dynamic> addExpenseData = addExpenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    List<ExpenseIncome> itemsList = List<ExpenseIncome>.from(
        addExpenseData.map<ExpenseIncome>((dynamic i) => ExpenseIncome.fromJson(i)));
    expenseIncomeList.addAll(itemsList);
    // for income
    QuerySnapshot addIncomeQuerySnapshot = await _addIncome.get();
    final List<dynamic> addIncomeData = addIncomeQuerySnapshot.docs.map((doc) => doc.data()).toList();
    print("addIncomeData    ${addExpenseQuerySnapshot}" );

    List<ExpenseIncome> addIncomeDataItemsList = List<ExpenseIncome>.from(
        addIncomeData.map<ExpenseIncome>((dynamic i) => ExpenseIncome.fromJson(i)));
    expenseIncomeList.addAll(addIncomeDataItemsList);
    // total expense
    for (var element in expenseIncomeList) {
      totalExpense += element.expense ;
      print("allData  ${expenseIncomeList.first.expense} ${expenseIncomeList.length}   $totalExpense");
    }
    //total income
    for (var element in expenseIncomeList) {
      totalIncome += element.income;
      print(
          "allExpenseData  ${expenseIncomeList.first.income} ${expenseIncomeList.length}   $totalIncome");
    }
     balance=totalIncome-totalExpense;
    // print("allData  ${expenseIncomeList.first.expense} ${expenseIncomeList.length} "
    //    " ${expenseIncomeList.first.income} ${expenseIncomeList.length}   $totalIncome  $totalExpense ");

     return expenseIncomeList;
  }

  Future<List<ExpenseIncome>?> getIncomeData() async {
    List<ExpenseIncome> expenseIncomeList = [];
    totalIncome=0;
    balance = 0;

    QuerySnapshot addIncomeQuerySnapshot = await _addIncome.get();
    final List<dynamic> addIncomeData = addIncomeQuerySnapshot.docs.map((doc) => doc.data()).toList();
    List<ExpenseIncome> addIncomeDataItemsList = List<ExpenseIncome>.from(
        addIncomeData.map<ExpenseIncome>((dynamic i) => ExpenseIncome.fromJson(i)));
    expenseIncomeList.addAll(addIncomeDataItemsList);
    for (var element in expenseIncomeList) {
      totalIncome += element.income;
      print("allExpenseData  ${expenseIncomeList.first.income} ${expenseIncomeList.length}   $totalIncome");

    }

    balance = totalIncome -  totalExpense;
    print(("Total Balance   $balance"));

    return addIncomeDataItemsList;
  }


  Future<List<ExpenseIncome>?> getExpenseData() async {
    List<ExpenseIncome> expenseIncomeList = [];
    totalExpense=0;
    balance = 0;
    QuerySnapshot addExpenseQuerySnapshot = await _addExpense.get();
    final List<dynamic> addExpenseData = addExpenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    List<ExpenseIncome> itemsList = List<ExpenseIncome>.from(
        addExpenseData.map<ExpenseIncome>((dynamic i) => ExpenseIncome.fromJson(i)));
    expenseIncomeList.addAll(itemsList);

    for (var element in expenseIncomeList) {
      totalExpense += element.expense;
      print("allData  ${expenseIncomeList.first.expense} ${expenseIncomeList.length}   $totalExpense");
    }


    balance = totalIncome - totalExpense;
    print(("Total Balance   $balance"));

    return itemsList;
  }

}
