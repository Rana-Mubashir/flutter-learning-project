import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/groups/group_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/groups/create_group_screen.dart';
import 'screens/groups/group_detail_screen.dart';
import 'screens/expenses/add_expense_screen.dart';
import 'screens/expenses/expense_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Split Bills',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/create-group': (context) => CreateGroupScreen(),
        '/group-details': (context) => GroupDetailScreen(groupId: 'default'),
        '/add-expense': (context) => AddExpenseScreen(groupId: 'default'),
        '/expense-details': (context) => ExpenseDetailScreen(expenseId: 'default'),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}