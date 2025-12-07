import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'group_detail_screen.dart'; // Add this import

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Your Groups',
                style: AppTextStyles.headline2,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildGroupItem(context, index), // Pass context here
              childCount: 4, // Sample data
            ),
          ),
        ],
      ),
    );
  }

  // Accept context as parameter
  Widget _buildGroupItem(BuildContext context, int index) {
    final groups = [
      {
        'name': 'Roommates',
        'members': 4,
        'balance': -25.00,
        'lastActivity': 'Today',
        'color': Colors.blue,
      },
      {
        'name': 'Work Team',
        'members': 6,
        'balance': 15.50,
        'lastActivity': 'Yesterday',
        'color': Colors.green,
      },
      {
        'name': 'Family',
        'members': 5,
        'balance': 0.00,
        'lastActivity': '3 days ago',
        'color': Colors.orange,
      },
      {
        'name': 'Weekend Trip',
        'members': 8,
        'balance': -42.75,
        'lastActivity': '1 week ago',
        'color': Colors.purple,
      },
    ];

    final group = groups[index];
    final balance = group['balance'] as double;

    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: group['color'] as Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                group['name'].toString().substring(0, 1),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          title: Text(
            group['name'].toString(),
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
                '${group['members']} members • ${group['lastActivity']}',
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
                balance == 0 ? 'Settled up' : '\$${balance.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: balance == 0 
                    ? AppColors.textSecondary 
                    : balance > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                balance == 0 ? '' : balance > 0 ? 'You get' : 'You owe',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupDetailScreen(groupId: 'group_$index'),
              ),
            );
          },
        ),
      ),
    );
  }
}