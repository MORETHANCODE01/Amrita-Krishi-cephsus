import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'customer_home_screen.dart'; // Assuming ProductItem is defined here or in a shared model file

class AllProductsScreen extends StatelessWidget {
  final List<ProductItem> allProducts; // Pass the list of products

  const AllProductsScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.builder(
         padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75, // Adjust as needed
          ),
          itemCount: allProducts.length,
          itemBuilder: (context, index) {
            // Reuse the _buildProductCard logic from CustomerHomeScreen
            // Ideally, this widget would be extracted into a separate file
            return _buildProductCard(context, allProducts[index]);
          },
        ),
    );
  }

   // Copied from CustomerHomeScreen - consider extracting to a shared widget
  Widget _buildProductCard(BuildContext context, ProductItem product) {
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
                   color: Colors.grey.shade100,
                   borderRadius: const BorderRadius.only(
                     topLeft: Radius.circular(12),
                     topRight: Radius.circular(12),
                   ),
                 ),
                 child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                   child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey.shade400)),
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
           ],
         ),
       ),
    );
  }
} 