import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';

/// All Hive reads/writes are funneled through this class.
/// The UI and Cubit never import `package:hive` directly.
class HiveService {
  static const String boxName = 'expenses';
  static late Box<Expense> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpenseAdapter());
    _box = await Hive.openBox<Expense>(boxName);
  }

  static List<Expense> getAllExpenses() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  static Future<void> addExpense(Expense expense) async {
    await _box.add(expense);
  }

  static Future<void> deleteExpense(Expense expense) async {
    await expense.delete();
  }

  static double get totalSpent {
    return _box.values.fold(0.0, (sum, e) => sum + e.amount);
  }

  static Map<ExpenseCategory, double> get spendingByCategory {
    final Map<ExpenseCategory, double> map = {};
    for (final e in _box.values) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }
}
