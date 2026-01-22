import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange[100],
                child: Icon(Icons.person, size: 60, color: Colors.orange),
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'john.doe@email.com',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              SizedBox(height: 32),
              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Shipping Address',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.favorite_border,
                title: 'Wishlist',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.history,
                title: 'Order History',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {},
              ),
              ProfileMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {},
                isRed: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isRed;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: isRed ? Colors.red : Colors.grey[700]),
        title: Text(
          title,
          style: TextStyle(
            color: isRed ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}
