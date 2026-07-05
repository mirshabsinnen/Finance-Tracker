import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.savings_outlined,
              size: 72,
              color: theme.colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No expenses tracked yet',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Tap '+' to start tracking your spending.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
