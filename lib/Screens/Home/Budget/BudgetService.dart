import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/BudgetModel.dart';

class BudgetService{

  final CollectionReference _budget =
  FirebaseFirestore.instance.collection('budget');


  Future<List<BudgetModel>?> retrieveBudget() async {
    List<BudgetModel> budgetList = [];

    QuerySnapshot addExpenseQuerySnapshot = await _budget.get();
    final List<dynamic> addExpenseData = addExpenseQuerySnapshot.docs.map((doc) => doc.data()).toList();
    List<BudgetModel> itemsList = List<BudgetModel>.from(
        addExpenseData.map<BudgetModel>((dynamic i) => BudgetModel.fromJson(i)));
    budgetList.addAll(itemsList);


    return itemsList;
  }

}