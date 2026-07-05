import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/expense_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../widgets/empty_state.dart';
import '../widgets/spending_pie_chart.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(symbol: '\$');
    final dateFormat = DateFormat('MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              return IconButton(
                icon: Icon(
                  mode == ThemeMode.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is! ExpenseLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.expenses.isEmpty) {
            return const EmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<ExpenseCubit>().loadExpenses(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total spent',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          currency.format(state.total),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SpendingPieChart(
                          byCategory: state.byCategory,
                          total: state.total,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Recent Expenses',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final expense in state.expenses)
                  Dismissible(
                    key: ValueKey(expense.key),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                    onDismissed: (_) =>
                        context.read<ExpenseCubit>().deleteExpense(expense),
                    child: Card(
                      child: ListTile(
                        title: Text(expense.description),
                        subtitle: Text(
                          '${expense.category.name} · ${dateFormat.format(expense.date)}',
                        ),
                        trailing: Text(
                          currency.format(expense.amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
