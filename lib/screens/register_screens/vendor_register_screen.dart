import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorRegisterScreen extends StatelessWidget {
  const VendorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor Registration', style: GoogleFonts.poppins())),
      body: Center(child: Text('Vendor Registration Screen', style: GoogleFonts.poppins())),
    );
  }
} 