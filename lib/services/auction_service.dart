import 'package:flutter/foundation.dart'; // For ChangeNotifier
import '../screens/farmer_screens/farmer_auctions_screen.dart'; // Import AuctionItem and AuctionStatus

// Simple service to manage auction state in memory (for simulation)
class AuctionService extends ChangeNotifier {
  // Private constructor
  AuctionService._privateConstructor();

  // Singleton instance
  static final AuctionService instance = AuctionService._privateConstructor();

  final List<AuctionItem> _auctions = [
     // Add initial dummy data (can be cleared later)
      AuctionItem(
      cropName: 'Wheat (Lokwan)',
      quantity: '50 Quintals',
      basePrice: 2150,
      currentBid: 2280,
      highestBidder: 'Aggarwal Traders',
      endTime: DateTime.now().add(const Duration(hours: 1, minutes: 30)),
      imageUrl: 'assets/crops/wheat.png',
      status: AuctionStatus.live,
      participants: 45,
      farmerId: 'farmer1', // Added for potential future use
      auctionId: 'auc123'
    ),
     AuctionItem(
      cropName: 'Rice (Basmati 1121)',
      quantity: '75 Quintals',
      basePrice: 3500,
      startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
      imageUrl: 'assets/crops/rice.png',
      status: AuctionStatus.upcoming,
      participants: 28,
      farmerId: 'farmer2',
      auctionId: 'auc124'
    ),
    AuctionItem(
      cropName: 'Potatoes (Kufri Jyoti)',
      quantity: '60 Quintals',
      basePrice: 1200,
      currentBid: 1350,
      highestBidder: 'Modern Vegetables',
      endTime: DateTime.now().add(const Duration(hours: 3, minutes: 45)),
      imageUrl: 'assets/crops/potato.png',
      status: AuctionStatus.live,
      participants: 32,
      farmerId: 'farmer3',
      auctionId: 'auc125'
    ),
    AuctionItem(
      cropName: 'Maize (Yellow Hybrid)',
      quantity: '80 Quintals',
      basePrice: 1800,
      startTime: DateTime.now().add(const Duration(days: 2, hours: 8)),
      imageUrl: 'assets/crops/maize.png',
      status: AuctionStatus.upcoming,
      participants: 18,
      farmerId: 'farmer1',
      auctionId: 'auc126'
    ),
    AuctionItem(
      cropName: 'Sugarcane (CO-0238)',
      quantity: '100 Quintals',
      basePrice: 350,
      startTime: DateTime.now().add(const Duration(days: 4)),
      imageUrl: 'assets/crops/sugarcane.png',
      status: AuctionStatus.upcoming,
      participants: 22,
      farmerId: 'farmer4',
      auctionId: 'auc127'
    ),
    AuctionItem(
      cropName: 'Tomatoes (Hybrid)',
      quantity: '30 Quintals',
      basePrice: 1600,
      finalPrice: 1750,
      winner: 'Fresh Produce Ltd',
      endTime: DateTime.now().subtract(const Duration(days: 2)),
      imageUrl: 'assets/crops/tomato.png',
      status: AuctionStatus.completed,
      participants: 38,
      farmerId: 'farmer2',
      auctionId: 'auc128'
    ),
    AuctionItem(
      cropName: 'Onions (Red)',
      quantity: '45 Quintals',
      basePrice: 1800,
      finalPrice: 2100,
      winner: 'Janta Vegetables',
      endTime: DateTime.now().subtract(const Duration(days: 5)),
      imageUrl: 'assets/crops/onion.png',
      status: AuctionStatus.completed,
      participants: 52,
      farmerId: 'farmer3',
      auctionId: 'auc129'
    ),
    AuctionItem(
      cropName: 'Mustard (Yellow)',
      quantity: '40 Quintals',
      basePrice: 5200,
      finalPrice: 5500,
      winner: 'Punjab Oil Mills',
      endTime: DateTime.now().subtract(const Duration(days: 8)),
      imageUrl: 'assets/crops/mustard.png',
      status: AuctionStatus.completed,
      participants: 25,
      farmerId: 'farmer1',
      auctionId: 'auc130'
    )
  ];

  List<AuctionItem> get allAuctions => List.unmodifiable(_auctions);

  List<AuctionItem> getAuctionsByStatus(AuctionStatus status) {
     // Update status based on time before returning
     _updateAuctionStatuses();
    return _auctions.where((AuctionItem a) => a.status == status).toList();
  }

  // Add a new auction created by a farmer
  void addAuction(AuctionItem auction) {
    _auctions.insert(0, auction); // Add to the beginning
    _updateAuctionStatuses();
    notifyListeners(); // Notify listeners about the change
  }

  // Simulate placing a bid by a vendor
  bool placeBid(String auctionId, int bidAmount, String vendorName) {
     _updateAuctionStatuses();
    try {
      final auctionIndex = _auctions.indexWhere((AuctionItem a) => a.auctionId == auctionId);
      if (auctionIndex != -1) {
        final AuctionItem auction = _auctions[auctionIndex];
        // Basic validation (live, bid higher than current/base)
        if (auction.status == AuctionStatus.live && bidAmount > (auction.currentBid ?? auction.basePrice)) {
          _auctions[auctionIndex] = auction.copyWith(
            currentBid: bidAmount,
            highestBidder: vendorName, // Simulate vendor name
            participants: (auction.participants ?? 0) + (auction.highestBidder != vendorName ? 1 : 0) // Simple participant count increment
          );
          notifyListeners();
          return true;
        } else {
          print('Bid validation failed: Status=${auction.status}, Bid=$bidAmount, Current=${auction.currentBid ?? auction.basePrice}');
          return false; // Bid not high enough or auction not live
        }
      } else {
        print('Auction not found: $auctionId');
        return false; // Auction not found
      }
    } catch (e) {
       print('Error placing bid: $e');
       return false;
    }
  }

  // Helper to update statuses based on time (call periodically or before fetching)
  void _updateAuctionStatuses() {
    final now = DateTime.now();
    bool changed = false;
    for (int i = 0; i < _auctions.length; i++) {
      final AuctionItem auction = _auctions[i];
      AuctionStatus originalStatus = auction.status;

      if (auction.status == AuctionStatus.upcoming && auction.startTime != null && now.isAfter(auction.startTime!)) {
         _auctions[i] = auction.copyWith(status: AuctionStatus.live);
         changed = true;
      }
       else if (auction.status == AuctionStatus.live && auction.endTime != null && now.isAfter(auction.endTime!)) {
         _auctions[i] = auction.copyWith(status: AuctionStatus.completed, finalPrice: auction.currentBid); // Set final price on completion
         changed = true;
      }

      // Add logic if needed to create past auctions if endtime passed
      if(originalStatus != _auctions[i].status) changed = true;
    }
     if (changed) {
       // Specify type for sort lambda arguments
      _auctions.sort((AuctionItem a, AuctionItem b) => (b.startTime ?? b.endTime ?? DateTime(0)).compareTo(a.startTime ?? a.endTime ?? DateTime(0)));
     }
  }

}

// Extend AuctionItem in farmer_auctions_screen.dart to include farmerId, auctionId and copyWith
// Add these lines to the AuctionItem class:
/*
  final String? farmerId; // To know who created it
  final String auctionId; // Unique ID

  AuctionItem({
    // ... existing params ...
    this.farmerId,
    required this.auctionId,
  });

  AuctionItem copyWith({
    // Add all fields here...
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
      auctionId: this.auctionId, // ID doesn't change
    );
  }
*/ 