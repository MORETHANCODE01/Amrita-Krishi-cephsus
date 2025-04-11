import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerToolsScreen extends StatefulWidget {
  const FarmerToolsScreen({super.key});

  @override
  State<FarmerToolsScreen> createState() => _FarmerToolsScreenState();
}

class _FarmerToolsScreenState extends State<FarmerToolsScreen> {
  final List<ToolItem> _tools = [
    ToolItem(
        name: 'Tractor (50 HP)',
        description: 'Heavy duty tractor for plowing and tilling large fields.',
        pricePerDay: 900,
        imageUrl: 'assets/tools/tractor.png', // Add tractor.png
        owner: 'Singh Machinery',
        location: 'Hoshiarpur, Punjab',
        rating: 4.5,
        isAvailable: true),
     ToolItem(
        name: 'Mini Tractor (25 HP)',
        description: 'Smaller tractor suitable for orchards and smaller plots.',
        pricePerDay: 600,
        imageUrl: 'assets/tools/mini_tractor.png', // Add mini_tractor.png
        owner: 'Kisan Rentals',
        location: 'Gurdaspur, Punjab',
        rating: 4.3,
        isAvailable: true),
    ToolItem(
        name: 'Rotavator (6 feet)',
        description: 'Efficiently prepares seedbeds by breaking up soil.',
        pricePerDay: 450,
        imageUrl: 'assets/tools/rotavator.png', // Add rotavator.png
        owner: 'Sharma Equipment',
        location: 'Jalandhar, Punjab',
        rating: 4.2,
        isAvailable: true),
    ToolItem(
        name: 'Combine Harvester (Wheat/Paddy)',
        description: 'Large capacity harvester for wheat and rice.',
        pricePerDay: 3000,
        imageUrl: 'assets/tools/harvester.png', // Add harvester.png
        owner: 'Punjab Agri Solutions',
        location: 'Ludhiana, Punjab',
        rating: 4.8,
        isAvailable: false),
    ToolItem(
        name: 'Power Sprayer (Petrol)',
        description: 'Motorized sprayer for pesticides and fertilizers, petrol engine.',
        pricePerDay: 250,
        imageUrl: 'assets/tools/sprayer_petrol.png', // Add sprayer_petrol.png
        owner: 'Krishna Agri Center',
        location: 'Amritsar, Punjab',
        rating: 4.0,
        isAvailable: true),
     ToolItem(
        name: 'Battery Sprayer (16L)',
        description: 'Electric sprayer, quieter operation, 16L capacity.',
        pricePerDay: 180,
        imageUrl: 'assets/tools/sprayer_battery.png', // Add sprayer_battery.png
        owner: 'Modern Kheti Store',
        location: 'Firozpur, Punjab',
        rating: 4.4,
        isAvailable: true),
    ToolItem(
        name: 'Seed Drill (Multi-crop)',
        description: 'Accurately sows seeds at required depth and spacing.',
        pricePerDay: 400,
        imageUrl: 'assets/tools/seed_drill.png', // Add seed_drill.png
        owner: 'Gupta Farm Supplies',
        location: 'Patiala, Punjab',
        rating: 4.3,
        isAvailable: true),
      ToolItem(
        name: 'Laser Land Leveler',
        description: 'Ensures perfectly level fields for efficient irrigation.',
        pricePerDay: 1500,
        imageUrl: 'assets/tools/laser_leveler.png', // Add laser_leveler.png
        owner: 'Punjab Agri Solutions',
        location: 'Ludhiana, Punjab',
        rating: 4.6,
        isAvailable: false),
       ToolItem(
        name: 'Paddy Transplanter (Manual)',
        description: 'Assists in transplanting paddy seedlings.',
        pricePerDay: 150,
        imageUrl: 'assets/tools/paddy_transplanter.png', // Add paddy_transplanter.png
        owner: 'Kisan Rentals',
        location: 'Gurdaspur, Punjab',
        rating: 4.1,
        isAvailable: true),
  ];

  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<ToolItem> get _filteredTools {
    List<ToolItem> filtered = _tools;

    if (_selectedCategory != 'All') {
      filtered = filtered.where((tool) {
        // Basic categorization logic (can be improved)
        if (_selectedCategory == 'Tractors') return tool.name.contains('Tractor');
        if (_selectedCategory == 'Harvesters') return tool.name.contains('Harvester');
        if (_selectedCategory == 'Sprayers') return tool.name.contains('Sprayer');
        if (_selectedCategory == 'Tillage') return tool.name.contains('Rotavator');
        return false;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((tool) =>
              tool.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              tool.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Rent Farming Tools',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for tools (e.g., tractor, sprayer)',
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

          // Category Filter
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildCategoryChip('All'),
                  _buildCategoryChip('Tractors'),
                  _buildCategoryChip('Harvesters'),
                  _buildCategoryChip('Sprayers'),
                  _buildCategoryChip('Tillage'),
                  _buildCategoryChip('Planting'),
                ],
              ),
            ),
          ),

          // Tool List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredTools.length,
              itemBuilder: (context, index) {
                return _buildToolCard(_filteredTools[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final bool isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedCategory = label;
            });
          }
        },
        labelStyle: GoogleFonts.poppins(
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.green.shade700,
          fontWeight: FontWeight.w500,
        ),
        selectedColor: Colors.green.shade700,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.green.shade200),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }

  Widget _buildToolCard(ToolItem tool) {
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
                        tool.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.construction, color: Colors.grey.shade400, size: 40)), // Placeholder Icon
                      ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tool.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tool.description,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
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
                            '${tool.rating}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.location_on, color: Colors.grey[600], size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              tool.location,
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
                      'Rent per day',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '₹${tool.pricePerDay}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: tool.isAvailable ? () {} : null,
                  icon: Icon(tool.isAvailable ? Icons.calendar_today : Icons.block, size: 16),
                  label: Text(tool.isAvailable ? 'Book Now' : 'Unavailable'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tool.isAvailable ? Colors.green.shade700 : Colors.grey.shade400,
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

class ToolItem {
  final String name;
  final String description;
  final int pricePerDay;
  final String imageUrl;
  final String owner;
  final String location;
  final double rating;
  final bool isAvailable;

  ToolItem({
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.imageUrl,
    required this.owner,
    required this.location,
    required this.rating,
    required this.isAvailable,
  });
} 