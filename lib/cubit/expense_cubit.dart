import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense.dart';
import '../services/hive_service.dart';

part 'expense_state.dart';

/// Business logic for expenses. The UI only ever talks to this Cubit —
/// never directly to HiveService.
class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial()) {
    loadExpenses();
  }

  void loadExpenses() {
    final expenses = HiveService.getAllExpenses();
    emit(ExpenseLoaded(
      expenses: expenses,
      total: HiveService.totalSpent,
      byCategory: HiveService.spendingByCategory,
    ));
  }

  Future<void> addExpense({
    required String description,
    required double amount,
    required ExpenseCategory category,
    DateTime? date,
  }) async {
    final expense = Expense(
      description: description,
      amount: amount,
      date: date ?? DateTime.now(),
      category: category,
    );
    await HiveService.addExpense(expense);
    loadExpenses();
  }

  Future<void> deleteExpense(Expense expense) async {
    await HiveService.deleteExpense(expense);
    loadExpenses();
  }
}
