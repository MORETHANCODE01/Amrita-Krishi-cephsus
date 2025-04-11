import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auction_service.dart';
import '../farmer_screens/farmer_auctions_screen.dart'; // For AuctionItem and AuctionStatus

class VendorAuctionsScreen extends StatefulWidget {
  const VendorAuctionsScreen({super.key});

  @override
  State<VendorAuctionsScreen> createState() => _VendorAuctionsScreenState();
}

class _VendorAuctionsScreenState extends State<VendorAuctionsScreen> {
  List<AuctionItem> _liveAuctions = [];
  List<AuctionItem> _upcomingAuctions = [];
  List<AuctionItem> _myBids = [];
  final String _vendorName = 'Aggarwal Traders'; // Replace with actual vendor data

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
    if (mounted) {
      setState(() {
        _liveAuctions = AuctionService.instance.getAuctionsByStatus(AuctionStatus.live);
        _upcomingAuctions = AuctionService.instance.getAuctionsByStatus(AuctionStatus.upcoming);
        
        // Get all auctions with my bids (simulated - in a real app, this would filter by vendorId)
        List<AuctionItem> allAuctions = [
          ...AuctionService.instance.getAuctionsByStatus(AuctionStatus.live),
          ...AuctionService.instance.getAuctionsByStatus(AuctionStatus.completed),
        ];
        
        // Filter for auctions where I'm the highest bidder
        _myBids = allAuctions.where((auction) => 
          auction.highestBidder == _vendorName || 
          auction.winner == _vendorName
        ).toList();
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
              Tab(text: 'My Bids'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAuctionList(_liveAuctions, isLive: true),
            _buildAuctionList(_upcomingAuctions, isLive: false),
            _buildAuctionList(_myBids, isLive: false, isMyBids: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAuctionList(List<AuctionItem> auctions, {required bool isLive, bool isMyBids = false}) {
    if (auctions.isEmpty) {
      return Center(
        child: Text(
          isMyBids 
            ? 'You haven\'t placed any bids yet.'
            : isLive 
              ? 'No live auctions at the moment.'
              : 'No upcoming auctions at the moment.',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        return _buildAuctionCard(auctions[index], isLive: isLive, isMyBid: isMyBids);
      },
    );
  }

  Widget _buildAuctionCard(AuctionItem auction, {required bool isLive, bool isMyBid = false}) {
    bool isHighestBidder = auction.highestBidder == _vendorName;
    bool isWinner = auction.winner == _vendorName;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.eco, color: Colors.grey.shade400, size: 40)),
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
                      Row(
                        children: [
                          Icon(Icons.person, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Farmer ID: ${auction.farmerId ?? 'Unknown'}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
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
            const Divider(height: 24, thickness: 1),
            
            // Price and bid information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Base Price:',
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                    ),
                    Text(
                      '₹${auction.basePrice}/quintal',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      auction.status == AuctionStatus.live 
                        ? 'Current Bid:' 
                        : auction.status == AuctionStatus.completed 
                          ? 'Final Price:' 
                          : 'Starts In:',
                      style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                    ),
                    Text(
                      auction.status == AuctionStatus.upcoming
                        ? _formatDateTime(auction.startTime!)
                        : '₹${auction.currentBid ?? auction.finalPrice ?? auction.basePrice}/quintal',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: auction.status == AuctionStatus.live ? Colors.orange.shade700 : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Auction status information
            const SizedBox(height: 16),
            if (auction.status == AuctionStatus.live) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Highest Bidder:',
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(
                        auction.highestBidder ?? 'No bids yet',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isHighestBidder ? Colors.green.shade700 : null,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Ends In:',
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(
                        _formatDuration(auction.endTime!.difference(DateTime.now())),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.gavel, size: 16),
                      label: Text(isHighestBidder ? 'Increase Bid' : 'Place Bid'),
                      onPressed: () => _showBidDialog(context, auction),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (auction.status == AuctionStatus.completed) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Winner:',
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(
                        auction.winner ?? 'Not available',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isWinner ? Colors.green.shade700 : null,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Ended On:',
                        style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(
                        _formatDateTime(auction.endTime!),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isWinner) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.call, size: 16),
                        label: const Text('Contact Farmer'),
                        onPressed: () {
                          // TODO: Implement contact farmer functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Contact feature will be implemented soon!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ] else if (auction.status == AuctionStatus.upcoming) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.notifications_active, size: 16),
                      label: const Text('Notify When Live'),
                      onPressed: () {
                        // TODO: Implement notification functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('You will be notified when this auction goes live!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

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
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.grey[700])),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final bidAmount = int.parse(bidController.text);
                // Use the service to place the bid
                bool success = AuctionService.instance.placeBid(
                  auction.auctionId,
                  bidAmount,
                  _vendorName, // Use current vendor's name
                );
                Navigator.of(ctx).pop(); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(success 
                    ? 'Bid placed successfully!' 
                    : 'Failed to place bid. (Check amount/status)'))
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade700,
              foregroundColor: Colors.white,
            ),
            child: Text('Place Bid', style: GoogleFonts.poppins()),
          ),
        ],
      ),
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