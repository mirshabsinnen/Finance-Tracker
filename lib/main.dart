import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/expense_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'screens/home_screen.dart';
import 'services/hive_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const FinanceTrackerApp());
}

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ExpenseCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'Finance Tracker',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
