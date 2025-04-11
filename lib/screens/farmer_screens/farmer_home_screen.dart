import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'farmer_chat_screen.dart';
import 'farmer_auctions_screen.dart';
import 'farmer_tools_screen.dart';
import 'farmer_marketplace_screen.dart';
import 'farmer_market_prices_screen.dart';
import 'farmer_crop_calendar_screen.dart';
import 'farmer_profile_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Farmer Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            tooltip: 'My Profile',
            onPressed: () {
              setState(() {
                _selectedIndex = 5;
              });
            },
          ),
        ],
      ),
      body: _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel_outlined),
            label: 'Auctions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_outlined),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey.shade600,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return const FarmerDashboard();
      case 1:
        return const FarmerChatScreen();
      case 2:
        return const FarmerAuctionsScreen();
      case 3:
        return const FarmerToolsScreen();
      case 4:
        return const FarmerMarketplaceScreen();
      case 5:
        return const FarmerProfileScreen();
      default:
        return const FarmerDashboard();
    }
  }
}

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section with farmer avatar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green.shade200,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green.shade800,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Ramesh Singh',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Verified Farmer',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weather Section
            _buildSectionTitle('Today\'s Weather'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '28°C',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Partly Cloudy',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Humidity: 65%',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Wind: 5 km/h',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white30, thickness: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWeatherForecast('Mon', Icons.wb_sunny_outlined, '27°'),
                      _buildWeatherForecast('Tue', Icons.cloud, '26°'),
                      _buildWeatherForecast('Wed', Icons.grain, '29°'),
                      _buildWeatherForecast('Thu', Icons.wb_sunny, '30°'),
                      _buildWeatherForecast('Fri', Icons.cloud, '27°'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Government Schemes Section
            _buildSectionTitle('Government Schemes'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSchemeItem(
                    context,
                    title: 'PM-KISAN',
                    description: 'Financial support of ₹6,000 per year for eligible farmer families',
                    icon: Icons.monetization_on_outlined,
                    color: Colors.orange.shade600,
                    onTap: () {},
                  ),
                  const Divider(height: 1, thickness: 1, indent: 70, endIndent: 20),
                  _buildSchemeItem(
                    context,
                    title: 'Kisan Credit Card',
                    description: 'Apply for credit up to ₹3 Lakh at reduced interest rate',
                    icon: Icons.credit_card,
                    color: Colors.green.shade600,
                    onTap: () {},
                  ),
                  const Divider(height: 1, thickness: 1, indent: 70, endIndent: 20),
                  _buildSchemeItem(
                    context,
                    title: 'Soil Health Card',
                    description: 'Get your soil tested for better crop planning',
                    icon: Icons.landscape_outlined,
                    color: Colors.brown.shade600,
                    onTap: () {},
                  ),
                  // Show All Button
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View All Schemes',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            _buildSectionTitle('Quick Actions'),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildQuickActionCard(
                  context,
                  icon: Icons.message,
                  title: 'AI\nAssistant',
                  color: Colors.purple.shade600,
                  onTap: () {
                    // Navigate to Chat Screen (using BottomNav index)
                    final homeState = context.findAncestorStateOfType<_FarmerHomeScreenState>();
                    homeState?.setState(() {
                      homeState._selectedIndex = 1;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildQuickActionCard(
                  context,
                  icon: Icons.gavel,
                  title: 'Crop\nAuctions',
                  color: Colors.orange.shade600,
                  onTap: () {
                    // Navigate to Auctions Screen (using BottomNav index)
                    final homeState = context.findAncestorStateOfType<_FarmerHomeScreenState>();
                    homeState?.setState(() {
                      homeState._selectedIndex = 2;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildQuickActionCard(
                  context,
                  icon: Icons.analytics,
                  title: 'Market\nPrices',
                  color: Colors.blue.shade600,
                  onTap: () {
                    // Navigate to Market Prices Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FarmerMarketPricesScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildQuickActionCard(
                  context,
                  icon: Icons.handyman,
                  title: 'Rent\nTools',
                  color: Colors.green.shade600,
                  onTap: () {
                    // Navigate to Tools Screen (using BottomNav index)
                    final homeState = context.findAncestorStateOfType<_FarmerHomeScreenState>();
                    homeState?.setState(() {
                      homeState._selectedIndex = 3;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildQuickActionCard(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'Buy\nSupplies',
                  color: Colors.red.shade600,
                  onTap: () {
                    // Navigate to Marketplace Screen (using BottomNav index)
                    final homeState = context.findAncestorStateOfType<_FarmerHomeScreenState>();
                    homeState?.setState(() {
                      homeState._selectedIndex = 4;
                    });
                  },
                ),
                const SizedBox(width: 16),
                _buildQuickActionCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Crop\nCalendar',
                  color: Colors.teal.shade600,
                  onTap: () {
                    // Navigate to Crop Calendar Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FarmerCropCalendarScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Agricultural News
            _buildSectionHeader('Agricultural News', () {}),
            const SizedBox(height: 12),
            _buildNewsCard(
              title: 'MSP for Kharif crops increased by 5-8% for 2025-26 season',
              date: 'Apr 10, 2025',
              imageUrl: 'https://example.com/news1.jpg',
              isUrgent: true,
            ),
            const SizedBox(height: 12),
            _buildNewsCard(
              title: 'New drought-resistant wheat variety released for northern regions',
              date: 'Apr 8, 2025',
              imageUrl: 'https://example.com/news2.jpg',
            ),
            const SizedBox(height: 12),
            _buildNewsCard(
              title: 'Government launches new subsidy program for organic farming',
              date: 'Apr 5, 2025',
              imageUrl: 'https://example.com/news3.jpg',
            ),
            const SizedBox(height: 24),

            // Upcoming Auctions
            _buildSectionHeader('Upcoming Auctions', () {}),
            const SizedBox(height: 12),
            _buildAuctionCard(
              cropName: 'Wheat',
              basePrice: '₹2,100/quintal',
              time: 'Tomorrow, 10:00 AM',
              participants: 28,
            ),
            const SizedBox(height: 12),
            _buildAuctionCard(
              cropName: 'Rice',
              basePrice: '₹1,950/quintal',
              time: 'Apr 15, 2:00 PM',
              participants: 42,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherForecast(String day, IconData icon, String temp) {
    return Column(
      children: [
        Text(
          day,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          temp,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
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
              color: Colors.green.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSchemeItem(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required String date,
    required String imageUrl,
    bool isUrgent = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUrgent)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                'IMPORTANT UPDATE',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.newspaper,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuctionCard({
    required String cropName,
    required String basePrice,
    required String time,
    required int participants,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.gavel,
                  size: 24,
                  color: Colors.orange.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cropName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Base Price: $basePrice',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$participants Vendors',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text('Join Auction'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Placeholder classes for the other tabs
class FarmerAuctionsScreen extends StatelessWidget {
  const FarmerAuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Auctions Screen',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FarmerToolsScreen extends StatelessWidget {
  const FarmerToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tools Rental Screen',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FarmerMarketplaceScreen extends StatelessWidget {
  const FarmerMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Marketplace Screen',
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
} 