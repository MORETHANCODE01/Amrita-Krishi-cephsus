import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all_products_screen.dart'; // Import the new screen
import 'customer_profile_screen.dart'; // Import Profile screen
import 'customer_chat_screen.dart'; // Import the AI chat screen

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  // TODO: Replace with actual data fetching
  final List<CategoryItem> _categories = [
    CategoryItem(
      name: 'Fresh Vegetables', 
      icon: Icons.local_florist, 
      imageUrl: 'https://images.unsplash.com/photo-1557844352-761f2023520d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
    CategoryItem(
      name: 'Fruits', 
      icon: Icons.apple, 
      imageUrl: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
    CategoryItem(
      name: 'Grains & Pulses', 
      icon: Icons.grain, 
      imageUrl: 'https://images.unsplash.com/photo-1604240610264-8c9bf6cfbae9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
    CategoryItem(
      name: 'Dairy Products', 
      icon: Icons.egg, 
      imageUrl: 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
    CategoryItem(
      name: 'Organic Produce', 
      icon: Icons.eco, 
      imageUrl: 'https://images.unsplash.com/photo-1600857544200-b2f666a9a2ec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
    CategoryItem(
      name: 'Spices', 
      icon: Icons.scatter_plot, 
      imageUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd0d65?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80'
    ),
  ];

  final List<ProductItem> _featuredProducts = [
    ProductItem(
      name: 'Fresh Tomatoes',
      price: 50,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1561136594-7f68413baa99?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Ram Kumar Farms',
      rating: 4.6
    ),
    ProductItem(
      name: 'Organic Apples',
      price: 150,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1570913149827-d2ac84ab3f9a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Green Valley Organics',
      rating: 4.8
    ),
    ProductItem(
      name: 'Basmati Rice',
      price: 120,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Punjab Grains',
      rating: 4.7
    ),
    ProductItem(
      name: 'Farm Fresh Milk',
      price: 60,
      unit: 'litre',
      imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Daily Dairy Farm',
      rating: 4.9
    ),
  ];

  final List<ProductItem> _allProducts = [ // Assuming you have a larger list or fetch it
    ProductItem(
      name: 'Fresh Tomatoes',
      price: 50,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1561136594-7f68413baa99?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Ram Kumar Farms',
      rating: 4.6
    ),
    ProductItem(
      name: 'Organic Apples',
      price: 150,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1570913149827-d2ac84ab3f9a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Green Valley Organics',
      rating: 4.8
    ),
    ProductItem(
      name: 'Basmati Rice',
      price: 120,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e8ac?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Punjab Grains',
      rating: 4.7
    ),
    ProductItem(
      name: 'Farm Fresh Milk',
      price: 60,
      unit: 'litre',
      imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Daily Dairy Farm',
      rating: 4.9
    ),
    ProductItem(
      name: 'Cauliflower',
      price: 40,
      unit: 'pc',
      imageUrl: 'https://images.unsplash.com/photo-1594282486552-05a9613eace4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Singh Vegetables',
      rating: 4.5
    ),
    ProductItem(
      name: 'Potatoes',
      price: 30,
      unit: 'kg',
      imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      farmer: 'Ram Kumar Farms',
      rating: 4.4
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Farmer Future Connect',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () { /* TODO: Implement search */ },
          ),
           IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
               setState(() { _selectedIndex = 1; }); // Navigate to Cart tab
            },
          ),
        ],
      ),
      body: _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Assistant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeTab() {
     return ListView(
        padding: EdgeInsets.zero,
        children: [
          // Welcome Banner or Promotions
          Container(
            height: 150,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.green.shade400, Colors.green.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
               boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Fresh From The Farm!',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Get the best quality produce delivered to your doorstep.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Shop by Category',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.only(left: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(_categories[index]);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Featured Products Section
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                  'Featured Products',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                 TextButton(
                  onPressed: () {
                    // Navigate to All Products Screen
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllProductsScreen(allProducts: _allProducts)), // Pass the full list
                    );
                   },
                  child: Text('View All', style: GoogleFonts.poppins(color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
                )
               ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Prevent grid scrolling inside ListView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Adjust aspect ratio as needed
              ),
              itemCount: _featuredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(_featuredProducts[index]);
              },
            ),
          ),
          // Add a bottom padding to prevent overflow
          const SizedBox(height: 16),
        ],
      );
  }

  Widget _buildCategoryCard(CategoryItem category) {
    return GestureDetector(
      onTap: () { /* TODO: Navigate to category products */ },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(4), // Adjust padding for image
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.blue.shade100)
              ),
              child: ClipRRect( // Clip image to rounded corners
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(category.icon, size: 35, color: Colors.blue.shade700), // Fallback icon
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductItem product) {
    return Card(
       elevation: 2,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
       child: InkWell(
         onTap: () { /* TODO: Navigate to product details */ },
         borderRadius: BorderRadius.circular(12),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Expanded(
               child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.grey.shade100, // Background color for error state
                   borderRadius: const BorderRadius.only(
                     topLeft: Radius.circular(12),
                     topRight: Radius.circular(12),
                   ),
                 ),
                 child: ClipRRect( // Clip image
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                   child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey.shade400)), // Fallback icon
                    ),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     product.name,
                     style: GoogleFonts.poppins(
                       fontSize: 14,
                       fontWeight: FontWeight.w600,
                       color: Colors.black87,
                     ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                   ),
                   const SizedBox(height: 2),
                   Text(
                      'By ${product.farmer}',
                     style: GoogleFonts.poppins(
                       fontSize: 11,
                       color: Colors.grey[600],
                     ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                   ),
                   const SizedBox(height: 4),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         '₹${product.price}/${product.unit}',
                         style: GoogleFonts.poppins(
                           fontSize: 14,
                           fontWeight: FontWeight.bold,
                           color: Colors.blue.shade800,
                         ),
                       ),
                       Row(
                         children: [
                           Icon(Icons.star, color: Colors.amber, size: 14),
                           const SizedBox(width: 2),
                           Text('${product.rating}', style: GoogleFonts.poppins(fontSize: 12)),
                         ],
                       )
                     ],
                   ),
                 ],
               ),
             ),
             // Add to Cart Button
             Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: ElevatedButton(
                    onPressed: (){
                      // TODO: Implement actual cart logic (e.g., using a CartService)
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text('${product.name} added to cart!'), duration: const Duration(seconds: 1)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue.shade700,
                      minimumSize: const Size(double.infinity, 34), // Make button full width
                      elevation: 0,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8),
                       ),
                       padding: const EdgeInsets.symmetric(vertical: 6)
                    ),
                    child: Text('Add to Cart', style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                ),
             )
           ],
         ),
       ),
    );
  }

  // Placeholder for other screens accessed by BottomNav
   Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
         return _buildHomeTab();
      case 1: // Cart
        return Center(child: Text('Cart Screen (Placeholder)', style: GoogleFonts.poppins()));
      case 2: // Orders
        return Center(child: Text('Orders Screen (Placeholder)', style: GoogleFonts.poppins()));
      case 3: // AI Assistant
        return const CustomerChatScreen();
      case 4: // Profile
        return const CustomerProfileScreen(); // Show Profile Screen
      default:
        return _buildHomeTab();
    }
  }

}

// Data Models (replace with your actual models)
class CategoryItem {
  final String name;
  final IconData icon;
  final String imageUrl;

  CategoryItem({required this.name, required this.icon, required this.imageUrl});
}

class ProductItem {
  final String name;
  final int price;
  final String unit;
  final String imageUrl;
  final String farmer;
  final double rating;

  ProductItem({
    required this.name,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.farmer,
    required this.rating,
  });
} 