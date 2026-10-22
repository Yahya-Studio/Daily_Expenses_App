import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:daily_expenses_app/screens/login_screen.dart';
import 'package:daily_expenses_app/screens/register_screen.dart';
import 'package:daily_expenses_app/screens/expenses_screen.dart';
import 'package:daily_expenses_app/screens/add_expense_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase Configuration via --dart-define or environment variables
  const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project-id.supabase.co',
  );
  const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key-here',
  );

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  runApp(const DailyExpensesApp());
}

class DailyExpensesApp extends StatelessWidget {
  const DailyExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if user is already logged in
    final session = Supabase.instance.client.auth.currentSession;
    final initialRoute = session != null ? '/expenses' : '/login';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/expenses': (context) => const ExpensesScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
      },
    );
  }
}
