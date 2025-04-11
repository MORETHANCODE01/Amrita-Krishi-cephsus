import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login_screens/farmer_login_screen.dart'; // For logout navigation

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  // TODO: Replace with actual farmer data
  final String farmerName = 'Ramesh Singh';
  final String phoneNumber = '+91 98765 43210';
  final String address = 'Village Pind, Tehsil Dasuya, Hoshiarpur, Punjab';
  final String aadharNumber = '**** **** 1234'; // Masked
  final String memberSince = 'January 2024';
  final double rating = 4.8;
  final int successfulAuctions = 25;
  final bool isVerified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('My Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
         automaticallyImplyLeading: false, // Remove back button if it's a main tab
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          _buildProfileHeader(context),
          const SizedBox(height: 24),

          // Profile Details Card
          _buildDetailsCard(),
          const SizedBox(height: 24),

          // Actions Card
          _buildActionsCard(context),
          const SizedBox(height: 24),

           // Statistics Card
          _buildStatsCard(),
          const SizedBox(height: 24),

          // Logout Button
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.green.shade200,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.green.shade800,
          ),
          // backgroundImage: NetworkImage('USER_IMAGE_URL'), // Uncomment if image available
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                farmerName,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                phoneNumber,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
              ),
               const SizedBox(height: 4),
               if (isVerified)
                  Row(
                    children: [
                      Icon(Icons.verified, size: 16, color: Colors.green.shade700),
                      const SizedBox(width: 4),
                      Text('Verified Farmer', style: GoogleFonts.poppins(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500)),
                    ],
                  ),
            ],
          ),
        ),
         IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.green.shade700),
            tooltip: 'Edit Profile',
            onPressed: () { /* TODO: Navigate to Edit Profile Screen */ },
          ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Card(
       elevation: 1,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Personal Details', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
             const Divider(height: 20),
            _buildDetailRow(Icons.location_on_outlined, 'Address', address),
            _buildDetailRow(Icons.credit_card_outlined, 'Aadhar', aadharNumber),
            _buildDetailRow(Icons.calendar_today_outlined, 'Member Since', memberSince),
          ],
        ),
      ),
    );
  }

   Widget _buildActionsCard(BuildContext context) {
    return Card(
       elevation: 1,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0), // Less vertical padding
        child: Column(
          children: [
            _buildActionRow(context, Icons.history, 'My Auction History', () { /* TODO: Navigate */ }),
             const Divider(height: 1, indent: 16, endIndent: 16),
            _buildActionRow(context, Icons.settings_outlined, 'Settings', () { /* TODO: Navigate */ }),
             const Divider(height: 1, indent: 16, endIndent: 16),
            _buildActionRow(context, Icons.help_outline, 'Help & Support', () { /* TODO: Navigate */ }),
          ],
        ),
      ),
    );
  }

   Widget _buildStatsCard() {
    return Card(
       elevation: 1,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Statistics', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
             const Divider(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 _buildStatColumn('Rating', '$rating ⭐', Colors.amber.shade700),
                 _buildStatColumn('Auctions Won by Vendors', successfulAuctions.toString(), Colors.green.shade700),
               ],
             )
          ],
        ),
      ),
    );
  }

   Widget _buildLogoutButton(BuildContext context) {
     return ElevatedButton.icon(
        onPressed: () {
           // Show confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  content: Text('Are you sure you want to log out?', style: GoogleFonts.poppins()),
                  actions: [
                    TextButton(
                      child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey[700])), 
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                    TextButton(
                      child: Text('Logout', style: GoogleFonts.poppins(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(ctx).pop(); // Close dialog
                        // Perform actual logout logic here (clear tokens, etc.)
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const FarmerLoginScreen()), // Or UserTypeScreen
                          (Route<dynamic> route) => false, // Remove all previous routes
                        );
                      },
                    ),
                  ],
                );
              },
            );
        },
        icon: const Icon(Icons.logout),
        label: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red,
          backgroundColor: Colors.red.shade50,
          elevation: 0,
           padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
   }


  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 2),
                Text(value, style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _buildActionRow(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(label, style: GoogleFonts.poppins()),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

   Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
} 