import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/profile_pic.png"), // Replace with network image if needed
            ),
            SizedBox(height: 10),

            // User Name
            Text(
              "Shivangi Singh",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            // Email
            Text(
              "shivangi@example.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // Profile Options
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(Icons.person, "Edit Profile", () {
                    // Navigate to Edit Profile Screen
                  }),
                  _buildProfileOption(Icons.notifications, "Notifications", () {}),
                  _buildProfileOption(Icons.lock, "Privacy & Security", () {}),
                  _buildProfileOption(Icons.help, "Help & Support", () {}),
                  _buildProfileOption(Icons.logout, "Logout", () {
                    // Handle logout
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Profile Option Widget
  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade700),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
