part of 'expense_cubit.dart';

abstract class ExpenseState {}

/// Before any data has been loaded from Hive.
class ExpenseInitial extends ExpenseState {}

/// Data has been loaded (this also covers the "empty list" case —
/// the UI decides whether to show the empty state based on the list length).
class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final double total;
  final Map<ExpenseCategory, double> byCategory;

  ExpenseLoaded({
    required this.expenses,
    required this.total,
    required this.byCategory,
  });
}
