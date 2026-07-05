import 'package:hive/hive.dart';

/// Spending categories available in the app.
enum ExpenseCategory { food, transport, shopping, bills, entertainment, health, other }

extension ExpenseCategoryLabel on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.shopping:
        return 'Shopping';
      case ExpenseCategory.bills:
        return 'Bills';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

/// A single expense entry. Extends [HiveObject] so instances can be
/// updated/deleted directly (e.g. `expense.delete()`).
class Expense extends HiveObject {
  String description;
  double amount;
  DateTime date;
  ExpenseCategory category;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });
}

/// Hand-written TypeAdapter — avoids needing build_runner/code generation.
/// typeId must be unique per model registered with Hive.
class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      description: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      category: ExpenseCategory.values[fields[3] as int],
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category.index);
  }
}
