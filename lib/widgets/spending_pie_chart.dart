import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class SpendingPieChart extends StatelessWidget {
  final Map<ExpenseCategory, double> byCategory;
  final double total;

  const SpendingPieChart({
    super.key,
    required this.byCategory,
    required this.total,
  });

  static const List<Color> _palette = [
    Color(0xFF3D5AFE),
    Color(0xFF00BFA5),
    Color(0xFFFFAB00),
    Color(0xFFFF5252),
    Color(0xFF7C4DFF),
    Color(0xFF29B6F6),
    Color(0xFF8D6E63),
  ];

  @override
  Widget build(BuildContext context) {
    final entries = byCategory.entries.toList();

    return SizedBox(
      height: 220,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  for (int i = 0; i < entries.length; i++)
                    PieChartSectionData(
                      value: entries[i].value,
                      color: _palette[i % _palette.length],
                      title: total == 0
                          ? ''
                          : '${(entries[i].value / total * 100).round()}%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _palette[i % _palette.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          entries[i].key.label,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
