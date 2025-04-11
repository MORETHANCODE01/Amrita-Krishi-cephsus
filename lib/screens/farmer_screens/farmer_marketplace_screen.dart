import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerMarketplaceScreen extends StatefulWidget {
  const FarmerMarketplaceScreen({super.key});

  @override
  State<FarmerMarketplaceScreen> createState() => _FarmerMarketplaceScreenState();
}

class _FarmerMarketplaceScreenState extends State<FarmerMarketplaceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Marketplace',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.poppins(),
          tabs: const [
            Tab(text: 'Seeds'),
            Tab(text: 'Fertilizers'),
            Tab(text: 'Pesticides'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MarketplaceList(category: 'Seeds'),
          MarketplaceList(category: 'Fertilizers'),
          MarketplaceList(category: 'Pesticides'),
        ],
      ),
    );
  }
}

class MarketplaceList extends StatefulWidget {
  final String category;
  const MarketplaceList({super.key, required this.category});

  @override
  State<MarketplaceList> createState() => _MarketplaceListState();
}

class _MarketplaceListState extends State<MarketplaceList> {
  // Dummy data - replace with actual data retrieval
  final Map<String, List<MarketItem>> _items = {
    'Seeds': [
      MarketItem(
          name: 'Wheat Seeds (Variety HD-3086)',
          description: 'High yield, disease resistant wheat variety.',
          price: 1200,
          unit: 'per 40kg bag',
          imageUrl: 'assets/market/wheat_seeds.png',
          seller: 'Punjab Seed Corp',
          rating: 4.7),
      MarketItem(
          name: 'Paddy Seeds (Variety PR-126)',
          description: 'Short duration, high yielding paddy seeds.',
          price: 850,
          unit: 'per 10kg bag',
          imageUrl: 'assets/market/paddy_seeds.png',
          seller: 'National Seeds Corp',
          rating: 4.5),
      MarketItem(
          name: 'Maize Seeds (Hybrid PMH-1)',
          description: 'High yielding hybrid maize seeds.',
          price: 950,
          unit: 'per 5kg bag',
          imageUrl: 'assets/market/maize_seeds.png',
          seller: 'Syngenta India',
          rating: 4.6),
    ],
    'Fertilizers': [
      MarketItem(
          name: 'Urea (46% Nitrogen)',
          description: 'Essential nitrogen fertilizer for plant growth.',
          price: 280,
          unit: 'per 45kg bag',
          imageUrl: 'assets/market/urea.png',
          seller: 'IFFCO',
          rating: 4.8),
      MarketItem(
          name: 'DAP (18-46-0)',
          description: 'Di-ammonium Phosphate, provides N and P.',
          price: 1350,
          unit: 'per 50kg bag',
          imageUrl: 'assets/market/dap.png',
          seller: 'Coromandel International',
          rating: 4.7),
      MarketItem(
          name: 'MOP (0-0-60)',
          description: 'Muriate of Potash, essential potassium source.',
          price: 1700,
          unit: 'per 50kg bag',
          imageUrl: 'assets/market/mop.png',
          seller: 'Indian Potash Limited',
          rating: 4.6),
      MarketItem(
          name: 'Organic Vermicompost',
          description: 'Natural soil conditioner, improves soil health.',
          price: 500,
          unit: 'per 50kg bag',
          imageUrl: 'assets/market/vermicompost.png',
          seller: 'Local Organic Farms',
          rating: 4.9),
    ],
    'Pesticides': [
      MarketItem(
          name: 'Imidacloprid 17.8% SL',
          description: 'Systemic insecticide for sucking pests.',
          price: 450,
          unit: 'per 250ml bottle',
          imageUrl: 'assets/market/imidacloprid.png',
          seller: 'Bayer CropScience',
          rating: 4.5),
      MarketItem(
          name: 'Mancozeb 75% WP',
          description: 'Broad-spectrum fungicide for disease control.',
          price: 600,
          unit: 'per 1kg pack',
          imageUrl: 'assets/market/mancozeb.png',
          seller: 'UPL Limited',
          rating: 4.4),
      MarketItem(
          name: 'Neem Oil (1500 PPM)',
          description: 'Organic insecticide and miticide.',
          price: 700,
          unit: 'per 1 litre bottle',
          imageUrl: 'assets/market/neem_oil.png',
          seller: 'GreenHarvest Organics',
          rating: 4.8),
    ],
  };

  String _searchQuery = '';

  List<MarketItem> get _filteredItems {
    List<MarketItem> categoryItems = _items[widget.category] ?? [];
    if (_searchQuery.isEmpty) {
      return categoryItems;
    }
    return categoryItems
        .where((item) =>
            item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar specific to the category
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search within ${widget.category}...',
              hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              return _buildMarketItemCard(_filteredItems[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMarketItemCard(MarketItem item) {
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
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.shopping_bag, color: Colors.grey.shade400, size: 40)), // Placeholder Icon
                      ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${item.rating}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.storefront, color: Colors.grey[600], size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.seller,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '₹${item.price}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.unit,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart, size: 16),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MarketItem {
  final String name;
  final String description;
  final int price;
  final String unit;
  final String imageUrl;
  final String seller;
  final double rating;

  MarketItem({
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.seller,
    required this.rating,
  });
} 