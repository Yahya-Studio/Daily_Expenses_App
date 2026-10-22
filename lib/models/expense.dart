class Expense {
  final String id;
  final String userId;
  final String title;
  final double amount;
  final DateTime expenseDate;
  final DateTime createdAt;

  Expense({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.expenseDate,
    required this.createdAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      expenseDate: DateTime.parse(json['expense_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'amount': amount,
      'expense_date': expenseDate.toIso8601String().split('T')[0], // YYYY-MM-DD
    };
  }
}
