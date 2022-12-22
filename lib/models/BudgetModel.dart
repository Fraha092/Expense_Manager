
class BudgetModel {
  String category = "";
  double amount = 0;
 // int icon;
 // int id;



  BudgetModel({ required this.category, required this.amount});

  factory BudgetModel.fromMap(map) {
    return BudgetModel(
     // id: map['id'],
    //  icon: map['icon'],
      category: map['category'],
      amount: map['amount'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
     // 'id':id,
      //'icon':icon,
      'category':category,
      'amount':amount,

    };
  }

  static fromJson(i) {
    BudgetModel budgetModel = BudgetModel( category: i["category"] ?? "" , amount:  i["amount"] ?? 0);//,icon: i["icon"] ?? 0);
    return budgetModel;

  }

}
