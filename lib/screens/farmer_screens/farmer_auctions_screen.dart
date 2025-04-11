import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_auction_screen.dart'; // Import the create auction screen
import '../../services/auction_service.dart'; // Import the service

class FarmerAuctionsScreen extends StatefulWidget {
  const FarmerAuctionsScreen({super.key});

  @override
  State<FarmerAuctionsScreen> createState() => _FarmerAuctionsScreenState();
}

class _FarmerAuctionsScreenState extends State<FarmerAuctionsScreen> {
  List<AuctionItem> _liveAuctions = [];
  List<AuctionItem> _upcomingAuctions = [];
  List<AuctionItem> _pastAuctions = [];

  @override
  void initState() {
    super.initState();
    // Listen to changes in the AuctionService
    AuctionService.instance.addListener(_updateAuctionLists);
    // Initial fetch
    _updateAuctionLists();
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    AuctionService.instance.removeListener(_updateAuctionLists);
    super.dispose();
  }

  void _updateAuctionLists() {
    if (mounted) { // Check if the widget is still in the tree
      setState(() {
        _liveAuctions = AuctionService.instance.getAuctionsByStatus(AuctionStatus.live);
        _upcomingAuctions = AuctionService.instance.getAuctionsByStatus(AuctionStatus.upcoming);
        _pastAuctions = AuctionService.instance.getAuctionsByStatus(AuctionStatus.completed);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            'Crop Auctions',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.orange.shade700,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.poppins(),
            tabs: const [
              Tab(text: 'Live'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAuctionList(_liveAuctions),
            _buildAuctionList(_upcomingAuctions),
            _buildAuctionList(_pastAuctions),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to create auction screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateAuctionScreen()),
            );
          },
          icon: const Icon(Icons.add),
          label: Text('Create Auction', style: GoogleFonts.poppins()),
          backgroundColor: Colors.orange.shade700,
        ),
      ),
    );
  }

  Widget _buildAuctionList(List<AuctionItem> auctions) {
    if (auctions.isEmpty) {
      return Center(
        child: Text(
          'No auctions in this category.',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        return _buildAuctionCard(auctions[index]);
      },
    );
  }

  Widget _buildAuctionCard(AuctionItem auction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                   child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        auction.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.eco, color: Colors.grey.shade400, size: 40)), // Placeholder
                      ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auction.cropName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quantity: ${auction.quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (auction.status == AuctionStatus.live || auction.status == AuctionStatus.completed)
                        Text(
                          auction.status == AuctionStatus.live
                              ? 'Base Price: ₹${auction.basePrice}/quintal'
                              : 'Base Price: ₹${auction.basePrice}/quintal',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      if (auction.status == AuctionStatus.upcoming)
                         Text(
                          'Base Price: ₹${auction.basePrice}/quintal',
                           style: GoogleFonts.poppins(
                             fontSize: 13,
                            color: Colors.grey[700],
                           ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(auction.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(auction.status),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: _getStatusColor(auction.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            if (auction.status == AuctionStatus.live)
              _buildLiveAuctionDetails(auction),
            if (auction.status == AuctionStatus.upcoming)
              _buildUpcomingAuctionDetails(auction),
            if (auction.status == AuctionStatus.completed)
              _buildPastAuctionDetails(auction),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveAuctionDetails(AuctionItem auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Current Bid:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              '₹${auction.currentBid}/quintal',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Highest Bidder:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              auction.highestBidder ?? '--',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ends in:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            // Add a countdown timer widget here
            Text(
              _formatDuration(auction.endTime!.difference(DateTime.now())),
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.red.shade700),
            ),
          ],
        ),
        const SizedBox(height: 12),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              '${auction.participants ?? 0} Vendors Participating',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('View Bids'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingAuctionDetails(AuctionItem auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Starts On:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              _formatDateTime(auction.startTime!),
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
         const SizedBox(height: 12),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              '${auction.participants ?? 0} Vendors Registered',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                 textStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('View Details'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPastAuctionDetails(AuctionItem auction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sold At:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              '₹${auction.finalPrice}/quintal',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Winner:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              auction.winner ?? '--',
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ended On:',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
            Text(
              _formatDateTime(auction.endTime!),
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              '${auction.participants ?? 0} Vendors Participated',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue.shade700, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                 textStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('View Summary'),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(AuctionStatus status) {
    switch (status) {
      case AuctionStatus.live:
        return Colors.red.shade600;
      case AuctionStatus.upcoming:
        return Colors.blue.shade600;
      case AuctionStatus.completed:
        return Colors.green.shade600;
    }
  }

  String _getStatusText(AuctionStatus status) {
    switch (status) {
      case AuctionStatus.live:
        return 'Live';
      case AuctionStatus.upcoming:
        return 'Upcoming';
      case AuctionStatus.completed:
        return 'Completed';
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else if (duration.inMinutes > 0) {
      return '$minutes:$seconds min';
    } else {
      return '$seconds sec';
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

enum AuctionStatus {
  live,
  upcoming,
  completed,
}

class AuctionItem {
  final String cropName;
  final String quantity;
  final int basePrice;
  final int? currentBid;
  final String? highestBidder;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? finalPrice;
  final String? winner;
  final String imageUrl;
  final AuctionStatus status;
  final int? participants;
  final String? farmerId;
  final String auctionId;

  AuctionItem({
    required this.cropName,
    required this.quantity,
    required this.basePrice,
    this.currentBid,
    this.highestBidder,
    this.startTime,
    this.endTime,
    this.finalPrice,
    this.winner,
    required this.imageUrl,
    required this.status,
    this.participants,
    this.farmerId,
    required this.auctionId,
  });

  AuctionItem copyWith({
    String? cropName,
    String? quantity,
    int? basePrice,
    int? currentBid,
    String? highestBidder,
    DateTime? startTime,
    DateTime? endTime,
    int? finalPrice,
    String? winner,
    String? imageUrl,
    AuctionStatus? status,
    int? participants,
    String? farmerId,
    String? auctionId,
  }) {
    return AuctionItem(
      cropName: cropName ?? this.cropName,
      quantity: quantity ?? this.quantity,
      basePrice: basePrice ?? this.basePrice,
      currentBid: currentBid ?? this.currentBid,
      highestBidder: highestBidder ?? this.highestBidder,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      finalPrice: finalPrice ?? this.finalPrice,
      winner: winner ?? this.winner,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      participants: participants ?? this.participants,
      farmerId: farmerId ?? this.farmerId,
      auctionId: auctionId ?? this.auctionId,
    );
  }
} 