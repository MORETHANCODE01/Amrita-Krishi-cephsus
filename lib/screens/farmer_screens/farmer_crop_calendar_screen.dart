import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerCropCalendarScreen extends StatelessWidget {
  const FarmerCropCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Calendar',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
         child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today_outlined, size: 80, color: Colors.teal.shade300),
              const SizedBox(height: 20),
              Text(
                'Crop Calendar Feature Coming Soon!',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
               const SizedBox(height: 10),
              Text(
                'Manage your crop schedules and activities here.',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 