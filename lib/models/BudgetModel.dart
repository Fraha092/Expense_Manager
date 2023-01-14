
class BudgetModel {
  String category = "";
  double amount = 0;



  BudgetModel({ required this.category, required this.amount});

  factory BudgetModel.fromMap(map) {
    return BudgetModel(

      category: map['category'],
      amount: map['amount'],

    );
  }

  Map<String, dynamic> toMap() {
    return {

      'category':category,
      'amount':amount,

    };
  }

  static fromJson(i) {
    BudgetModel budgetModel = BudgetModel( category: i["category"] ?? "" , amount:  i["amount"] ?? 0);//,icon: i["icon"] ?? 0);
    return budgetModel;

  }

}
