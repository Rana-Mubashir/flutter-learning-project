import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController = TextEditingController();
  List<String> _selectedMembers = [];
  final List<String> _availableMembers = [
    'Sarah Wilson',
    'Mike Chen',
    'Emma Davis',
    'James Brown',
    'Lisa Taylor',
    'David Miller'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: _createGroup,
            child: Text(
              'Create',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group Name
            _buildGroupNameField(),
            SizedBox(height: 20),
            
            // Group Description
            _buildDescriptionField(),
            SizedBox(height: 24),
            
            // Selected Members
            _buildSelectedMembers(),
            SizedBox(height: 16),
            
            // Add Members Section
            _buildAddMembersSection(),
            SizedBox(height: 16),
            
            // Available Members List
            _buildAvailableMembers(),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Group Name *',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _groupNameController,
          decoration: InputDecoration(
            hintText: 'e.g., Roommates, Work Team, Family',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description (Optional)',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _groupDescriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Describe the purpose of this group...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedMembers() {
    if (_selectedMembers.isEmpty) {
      return SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Members',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedMembers.map((member) {
            return Chip(
              label: Text(member),
              onDeleted: () {
                setState(() {
                  _selectedMembers.remove(member);
                });
              },
              backgroundColor: AppColors.primary.withOpacity(0.1),
              deleteIconColor: AppColors.primary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAddMembersSection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Add Members',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ),
        Text(
          '${_selectedMembers.length} selected',
          style: TextStyle(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableMembers() {
    return Column(
      children: _availableMembers.map((member) {
        final isSelected = _selectedMembers.contains(member);
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: AppColors.primary,
              ),
            ),
            title: Text(
              member,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              'Friend',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedMembers.add(member);
                  } else {
                    _selectedMembers.remove(member);
                  }
                });
              },
              activeColor: AppColors.primary,
            ),
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedMembers.remove(member);
                } else {
                  _selectedMembers.add(member);
                }
              });
            },
          ),
        );
      }).toList(),
    );
  }

  void _createGroup() {
    final groupName = _groupNameController.text.trim();
    
    if (groupName.isEmpty) {
      _showErrorDialog('Please enter a group name');
      return;
    }
    
    if (_selectedMembers.isEmpty) {
      _showErrorDialog('Please add at least one member to the group');
      return;
    }
    
    // For now, just go back to groups screen
    Navigator.pop(context);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}