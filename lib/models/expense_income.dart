
class ExpenseIncome {
  double expense = 0;
  double income = 0;
  String category = "";
  String? payment = "";
  String? dates= "";
  String? times= "";
  String? notes= "";

  ExpenseIncome({required this.expense, required this.income, required this.category,
    required this.payment,required this.dates,required this.times,required this.notes});

  factory ExpenseIncome.fromMap(map) {
    return ExpenseIncome(
      expense: map['expense'],
      income: map['income'],
      category: map['category'],
      payment: map['payment'],
      dates: map['dates'],
      times: map['times'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expense':expense,
      'income':income,
      'category':category,
      'payment':payment,
      'dates':dates,
      'times':times,
      'notes': notes,
    };
  }

  static fromJson(i) {
    ExpenseIncome expenseIncome = ExpenseIncome(expense: i["expense"] ?? 0 , income:  i["income"] ?? 0, category:  i["category"], payment:  i["payment"], dates:  i["dates"], times:  i["times"], notes:  i["notes"]);
    return expenseIncome;

  }

}
