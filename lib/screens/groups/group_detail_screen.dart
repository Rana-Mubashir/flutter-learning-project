import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class GroupDetailScreen extends StatelessWidget {
  final String groupId; // We'll pass this when navigating

  GroupDetailScreen({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Roommates'),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _showGroupOptions(context);
              },
            ),
          ],
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Expenses'),
              Tab(text: 'Balances'),
              Tab(text: 'Members'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExpensesTab(context), // Pass context here
            _buildBalancesTab(context), // Pass context here
            _buildMembersTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add-expense', arguments: groupId);
          },
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Accept context as parameter
  Widget _buildExpensesTab(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildExpenseItem(
          context: context, // Pass context here
          title: 'Groceries',
          paidBy: 'You',
          amount: 120.00,
          date: 'Today',
          splitBetween: 4,
        ),
        _buildExpenseItem(
          context: context, // Pass context here
          title: 'Electricity Bill',
          paidBy: 'Sarah',
          amount: 85.50,
          date: 'Yesterday',
          splitBetween: 4,
        ),
        _buildExpenseItem(
          context: context, // Pass context here
          title: 'Internet Bill',
          paidBy: 'Mike',
          amount: 65.00,
          date: '3 days ago',
          splitBetween: 4,
        ),
      ],
    );
  }

  // Accept context as parameter
  Widget _buildExpenseItem({
    required BuildContext context,
    required String title,
    required String paidBy,
    required double amount,
    required String date,
    required int splitBetween,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.receipt, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              'Paid by $paidBy • $date',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Split between $splitBetween people',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'You owe \$${(amount / splitBetween).toStringAsFixed(2)}',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/expense-details');
        },
      ),
    );
  }

  // Accept context as parameter
  Widget _buildBalancesTab(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildBalanceItem(
          context: context, // Pass context here
          person: 'Sarah Wilson',
          amount: 25.50,
          youOwe: false,
        ),
        _buildBalanceItem(
          context: context, // Pass context here
          person: 'Mike Chen',
          amount: 15.00,
          youOwe: true,
        ),
        _buildBalanceItem(
          context: context, // Pass context here
          person: 'You',
          amount: 0.00,
          youOwe: false,
        ),
        _buildBalanceItem(
          context: context, // Pass context here
          person: 'Emma Davis',
          amount: 10.50,
          youOwe: false,
        ),
      ],
    );
  }

  // Accept context as parameter
  Widget _buildBalanceItem({
    required BuildContext context,
    required String person,
    required double amount,
    required bool youOwe,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: amount == 0 
                ? Colors.grey.withOpacity(0.1)
                : (youOwe ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            amount == 0 ? Icons.check : (youOwe ? Icons.arrow_upward : Icons.arrow_downward),
            color: amount == 0 ? Colors.grey : (youOwe ? Colors.red : Colors.green),
          ),
        ),
        title: Text(
          person,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          amount == 0 ? 'Settled up' : (youOwe ? 'You owe' : 'Owes you'),
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Text(
          amount == 0 ? 'Settled' : '\$${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: amount == 0 
                ? AppColors.textSecondary 
                : (youOwe ? Colors.red : Colors.green),
          ),
        ),
        onTap: () {
          if (amount != 0) {
            _showSettleUpDialog(context, person, amount, youOwe);
          }
        },
      ),
    );
  }

  Widget _buildMembersTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildMemberItem(
          name: 'You',
          email: 'alex.johnson@email.com',
          isYou: true,
        ),
        _buildMemberItem(
          name: 'Sarah Wilson',
          email: 'sarah.wilson@email.com',
          isYou: false,
        ),
        _buildMemberItem(
          name: 'Mike Chen',
          email: 'mike.chen@email.com',
          isYou: false,
        ),
        _buildMemberItem(
          name: 'Emma Davis',
          email: 'emma.davis@email.com',
          isYou: false,
        ),
      ],
    );
  }

  Widget _buildMemberItem({
    required String name,
    required String email,
    required bool isYou,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, color: AppColors.primary),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          email,
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: isYou 
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'You',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _showGroupOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: AppColors.primary),
                title: Text('Edit Group'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to edit group
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, color: AppColors.primary),
                title: Text('Add Members'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Add members functionality
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text('Leave Group', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showLeaveGroupDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLeaveGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Leave Group?'),
        content: Text('Are you sure you want to leave this group? You will lose access to all group expenses.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to groups screen
            },
            child: Text(
              'Leave',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettleUpDialog(BuildContext context, String person, double amount, bool youOwe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Settle Up'),
        content: Text(
          youOwe
              ? 'You owe $person \$${amount.toStringAsFixed(2)}. Mark this as settled?'
              : '$person owes you \$${amount.toStringAsFixed(2)}. Mark this as settled?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement settle up functionality
            },
            child: Text('Mark as Settled'),
          ),
        ],
      ),
    );
  }
}