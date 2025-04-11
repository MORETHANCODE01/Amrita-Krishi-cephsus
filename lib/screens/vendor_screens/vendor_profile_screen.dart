import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login_screens/vendor_login_screen.dart'; // For logout

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  // TODO: Replace with actual vendor data
  final String businessName = 'Aggarwal Traders';
  final String email = 'contact@aggarwaltraders.com';
  final String phoneNumber = '+91 181 1234567';
  final String address = '45, New Market, Hoshiarpur, Punjab';
  final String gstNumber = '03ABCDE1234F1Z5';
  final String memberSince = 'February 2024';
  final double rating = 4.7;
   final int activeBids = 3;
  final int wonAuctions = 12;
  final bool isVerified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('My Business Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
         automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          _buildProfileHeader(context),
          const SizedBox(height: 24),

          // Business Details Card
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
          backgroundColor: Colors.orange.shade100,
          child: Icon(
            Icons.store,
            size: 45,
            color: Colors.orange.shade800,
          ),
           // backgroundImage: NetworkImage('BUSINESS_LOGO_URL'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                businessName,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
              ),
                const SizedBox(height: 4),
               if (isVerified)
                  Row(
                    children: [
                      Icon(Icons.verified_user, size: 16, color: Colors.green.shade700),
                      const SizedBox(width: 4),
                      Text('GST Verified', style: GoogleFonts.poppins(fontSize: 12, color: Colors.green.shade700, fontWeight: FontWeight.w500)),
                    ],
                  ),
            ],
          ),
        ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Colors.orange.shade700),
            tooltip: 'Edit Business Profile',
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
             Text('Business Information', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
             const Divider(height: 20),
            _buildDetailRow(Icons.phone_outlined, 'Phone', phoneNumber),
             _buildDetailRow(Icons.confirmation_number_outlined, 'GSTIN', gstNumber),
            _buildDetailRow(Icons.location_on_outlined, 'Address', address),
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
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _buildActionRow(context, Icons.gavel_outlined, 'My Bids & Auctions', () { /* TODO: Navigate */ }),
             const Divider(height: 1, indent: 16, endIndent: 16),
             _buildActionRow(context, Icons.message_outlined, 'Messages', () { /* TODO: Navigate */ }),
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
                 _buildStatColumn('Active Bids', activeBids.toString(), Colors.orange.shade700),
                 _buildStatColumn('Auctions Won', wonAuctions.toString(), Colors.green.shade700),
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
                          MaterialPageRoute(builder: (context) => const VendorLoginScreen()), // Or UserTypeScreen
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