import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vendor_profile_screen.dart'; // Import Profile screen
import 'vendor_auctions_screen.dart'; // Import Auctions screen
import 'vendor_community_screen.dart'; // Import Community screen
import '../../services/auction_service.dart'; // Import service
import '../farmer_screens/farmer_auctions_screen.dart'; // Import AuctionItem/Status

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  int _selectedIndex = 0;

  // TODO: Replace with actual data
  final String _businessName = 'Aggarwal Traders';
  final int _activeAuctions = 3;
  final int _successfulBids = 12;
  final double _rating = 4.7;
  final bool _isVerified = true; // Assuming GST is verified

  final List<Map<String, dynamic>> _recentBids = [
    {'crop': 'Wheat (Lokwan)', 'myBid': 2280, 'status': 'Highest', 'farmer': 'Ramesh Singh'},
    {'crop': 'Potatoes (Jyoti)', 'myBid': 1190, 'status': 'Highest', 'farmer': 'Sita Devi'},
    {'crop': 'Mustard Seed', 'myBid': 5800, 'status': 'Outbid (₹5850)', 'farmer': 'Karan Kumar'},
  ];

  // Replace dummy _nearbyAuctions with data from service
  // final List<Map<String, dynamic>> _nearbyAuctions = [...];
  List<AuctionItem> _nearbyAuctions = [];

  @override
  void initState() {
    super.initState();
    AuctionService.instance.addListener(_updateVendorDashboard);
    _updateVendorDashboard(); // Initial fetch
  }

  @override
  void dispose() {
    AuctionService.instance.removeListener(_updateVendorDashboard);
    super.dispose();
  }

  void _updateVendorDashboard() {
    if(mounted) {
      setState(() {
        // Fetch live and upcoming auctions - simulate "nearby"
        _nearbyAuctions = [
          ...AuctionService.instance.getAuctionsByStatus(AuctionStatus.live),
          ...AuctionService.instance.getAuctionsByStatus(AuctionStatus.upcoming)
        ];
         // TODO: Add actual location filtering logic
         // TODO: Update _recentBids based on actual vendor bids
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO: Handle navigation for other tabs (Auctions, Messages, Profile)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vendor Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () { /* TODO: Implement notifications */ },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
            onPressed: () {
               setState(() { _selectedIndex = 3; }); // Navigate to Profile tab
            },
          ),
        ],
      ),
       body: _selectedIndex == 0 ? _buildDashboardTab() : _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'Auctions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange.shade700,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDashboardTab() {
     return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Business Profile Summary
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.store, color: Colors.orange.shade700, size: 30),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _businessName,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                       if (_isVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                             mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, size: 14, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Text('Verified', style: GoogleFonts.poppins(fontSize: 11, color: Colors.green.shade700, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        )
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Active Bids', _activeAuctions.toString(), Icons.gavel, Colors.orange.shade600),
                      _buildStatItem('Won Auctions', _successfulBids.toString(), Icons.emoji_events, Colors.green.shade600),
                      _buildStatItem('Rating', _rating.toString(), Icons.star, Colors.amber.shade600),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Recent Bids Section
           _buildSectionHeader('Your Recent Bids', () { setState(() { _selectedIndex = 1; }); }), // Navigate to Auctions tab
          const SizedBox(height: 12),
          Column(
             children: _recentBids.map((bid) => _buildRecentBidCard(bid)).toList(),
          ),
           const SizedBox(height: 24),

          // Nearby Auctions Section - Updated
          _buildSectionHeader('Nearby Auctions', () { setState(() { _selectedIndex = 1; }); }),
          const SizedBox(height: 12),
          _nearbyAuctions.isEmpty
             ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(child: Text('No nearby auctions found.', style: GoogleFonts.poppins(color: Colors.grey[600]))),
               )
             : Column(
                 children: _nearbyAuctions.map((auction) => _buildNearbyAuctionCard(auction)).toList(),
               ),
          const SizedBox(height: 24),

        ],
      );
  }

   Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 28, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

    Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            'View All',
            style: GoogleFonts.poppins(
              color: Colors.orange.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

    Widget _buildRecentBidCard(Map<String, dynamic> bid) {
      Color statusColor;
      String statusText = bid['status'];
      if(statusText == 'Highest') statusColor = Colors.green.shade600;
      else if(statusText.contains('Outbid')) statusColor = Colors.red.shade600;
      else statusColor = Colors.grey.shade600;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
       elevation: 1,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
           children: [
            Icon(Icons.eco, color: Colors.green.shade700, size: 24),
             const SizedBox(width: 12),
             Expanded(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                      bid['crop'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Your Bid: ₹${bid['myBid']}/quintal',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                 ],
               ),
             ),
             const SizedBox(width: 12),
              Text(
               statusText,
               style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              )
           ],
        ),
      ),
    );
  }

    Widget _buildNearbyAuctionCard(AuctionItem auction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
       elevation: 1,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            // Use auction image or placeholder
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    auction.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.eco, color: Colors.grey.shade400, size: 30)),
                  ),
              ),
            ),
             const SizedBox(width: 12),
             Expanded(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(
                      auction.cropName,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Base: ₹${auction.basePrice}/quintal | ${auction.status == AuctionStatus.live ? "Live" : "Upcoming"}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                 ],
               ),
             ),
             const SizedBox(width: 12),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                        // TODO: Navigate to Auction Details / Bidding Screen
                         _showBidDialog(context, auction); // Temporary bid dialog
                      },
                    child: Text(auction.status == AuctionStatus.live ? 'Bid Now' : 'View'),
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.orange.shade700,
                       foregroundColor: Colors.white,
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                       textStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)
                    ),
                  ),
                   // TODO: Replace distance placeholder
                  // const SizedBox(height: 2),
                  // Text(auction['distance'], style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]))
                ],
              )
           ],
        ),
      ),
    );
  }

    // --- TEMPORARY BID DIALOG --- (Replace with proper navigation/screen)
   void _showBidDialog(BuildContext context, AuctionItem auction) {
    final bidController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Place Bid on ${auction.cropName}', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Bid: ₹${auction.currentBid ?? auction.basePrice}/quintal', style: GoogleFonts.poppins()),
              const SizedBox(height: 16),
              TextFormField(
                controller: bidController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Your Bid per Quintal',
                  prefixText: '₹',
                  border: const OutlineInputBorder(),
                   hintText: 'Must be > ${auction.currentBid ?? auction.basePrice}',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter bid amount';
                  final amount = int.tryParse(value);
                  if (amount == null || amount <= (auction.currentBid ?? auction.basePrice)) {
                    return 'Bid must be higher than current bid/base price';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final bidAmount = int.parse(bidController.text);
                // Use the service to place the bid
                bool success = AuctionService.instance.placeBid(
                  auction.auctionId,
                  bidAmount,
                  _businessName, // Use current vendor's name
                );
                Navigator.of(ctx).pop(); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(success ? 'Bid placed successfully!' : 'Failed to place bid. (Check amount/status)')),
                );
              }
            },
            child: Text('Place Bid'),
          ),
        ],
      ),
    );
  }

  // Placeholder for other screens accessed by BottomNav
   Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1: // Auctions
        return const VendorAuctionsScreen(); // Use the new auctions screen
      case 2: // Community (formerly Messages)
        return const VendorCommunityScreen(); // Use the new community screen
      case 3: // Profile
        return const VendorProfileScreen(); // Show Profile Screen
      default:
        return _buildDashboardTab();
    }
  }
} 