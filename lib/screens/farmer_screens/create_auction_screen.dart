import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date/time formatting
import '../../services/auction_service.dart'; // Import service
import 'farmer_auctions_screen.dart'; // Import AuctionItem/Status
import 'dart:math'; // For random ID generation

class CreateAuctionScreen extends StatefulWidget {
  const CreateAuctionScreen({super.key});

  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _basePriceController = TextEditingController();
  DateTime? _auctionEndTime;
  TimeOfDay? _auctionEndTimeOfDay;

  String? _selectedQuantityUnit = 'Quintals';
  final List<String> _quantityUnits = ['Quintals', 'Tonnes', 'Kgs'];

  @override
  void dispose() {
    _cropNameController.dispose();
    _quantityController.dispose();
    _basePriceController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _auctionEndTime ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)), // Limit auction end time to 30 days
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: _auctionEndTimeOfDay ?? TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1))),
       );

        if (pickedTime != null) {
           setState(() {
             _auctionEndTime = DateTime(
               pickedDate.year,
               pickedDate.month,
               pickedDate.day,
               pickedTime.hour,
               pickedTime.minute,
             );
             _auctionEndTimeOfDay = pickedTime;
           });
        }
    }
  }

  String _formatDateTime(DateTime dt) {
    // Using intl package for better formatting
    return DateFormat('EEE, MMM d, yyyy hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Create New Auction',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   // Section Title
                  Text(
                    'Enter Crop Details',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Crop Name Field
                  _buildTextFormField(
                    controller: _cropNameController,
                    label: 'Crop Name & Variety',
                    hint: 'e.g., Wheat (Lokwan), Basmati Rice 1121',
                    icon: Icons.eco_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the crop name and variety';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Quantity Field
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildTextFormField(
                          controller: _quantityController,
                          label: 'Quantity',
                          hint: 'e.g., 50',
                          icon: Icons.scale_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter quantity';
                            }
                            if (double.tryParse(value) == null || double.parse(value) <= 0) {
                              return 'Enter a valid positive quantity';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: DropdownButtonFormField<String>(
                          value: _selectedQuantityUnit,
                          items: _quantityUnits.map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit, style: GoogleFonts.poppins(fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedQuantityUnit = newValue;
                            });
                          },
                          decoration: InputDecoration(
                             labelText: 'Unit',
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          ),
                           validator: (value) => value == null ? 'Select unit' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Base Price Field
                  _buildTextFormField(
                    controller: _basePriceController,
                    label: 'Base Price per Quintal',
                    hint: 'Enter starting price in ₹ per quintal',
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                       if (value == null || value.isEmpty) {
                        return 'Enter base price';
                      }
                       if (int.tryParse(value) == null || int.parse(value) <= 0) {
                        return 'Enter a valid positive price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                   // Auction End Time Picker
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Auction End Date & Time',
                      hintText: _auctionEndTime == null
                          ? 'Select when the auction should end'
                          : _formatDateTime(_auctionEndTime!),
                      prefixIcon: Icon(Icons.timer_outlined, color: Colors.orange.shade700),
                       border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
                      ),
                      suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
                    ),
                    style: GoogleFonts.poppins(),
                    onTap: () => _selectDateTime(context),
                     validator: (value) {
                      if (_auctionEndTime == null) {
                        return 'Please select an auction end time';
                      }
                       if (_auctionEndTime!.isBefore(DateTime.now().add(const Duration(minutes: 30)))) {
                        return 'End time must be at least 30 minutes from now';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // TODO: Add image upload section
                   Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image_outlined, color: Colors.grey.shade600),
                        const SizedBox(width: 12),
                        Text('Upload Crop Images (Optional)', style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                        const Spacer(),
                        Icon(Icons.add_a_photo_outlined, color: Colors.orange.shade700),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Create Auction Button
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create new AuctionItem
                        final newAuction = AuctionItem(
                          auctionId: 'auc${Random().nextInt(99999)}', // Simple unique ID
                          cropName: _cropNameController.text,
                          quantity: '${_quantityController.text} ${_selectedQuantityUnit ?? "Units"}',
                          basePrice: int.parse(_basePriceController.text),
                          imageUrl: 'assets/crops/placeholder.png', // Default placeholder
                          startTime: DateTime.now(), // Auction starts now
                          endTime: _auctionEndTime!,
                          status: AuctionStatus.live, // Start as live
                          farmerId: 'current_farmer_id', // TODO: Replace with actual farmer ID
                          participants: 0,
                        );

                        // Add auction to the service
                        AuctionService.instance.addAuction(newAuction);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Auction created successfully!')),
                        );
                        // Navigate back after a delay
                        Future.delayed(const Duration(seconds: 1), () {
                          if(mounted) Navigator.of(context).pop(); // Go back to the auctions list
                        });
                      }
                    },
                    icon: const Icon(Icons.gavel),
                    label: Text(
                      'START AUCTION',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.orange.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange.shade700, width: 2),
        ),
         labelStyle: GoogleFonts.poppins(fontSize: 14),
         hintStyle: GoogleFonts.poppins(fontSize: 14),
      ),
      style: GoogleFonts.poppins(),
      validator: validator,
    );
  }
} 