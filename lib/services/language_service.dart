import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  
  // Singleton pattern
  factory LanguageService() {
    return _instance;
  }
  
  LanguageService._internal();
  
  static LanguageService get instance => _instance;
  
  // Current language selection
  String _currentLanguage = 'English';
  
  // Available languages
  final List<String> supportedLanguages = ['English', 'हिंदी', 'ಕನ್ನಡ'];
  
  // Language translation maps for each user type
  final Map<String, Map<String, String>> _commonTranslations = {
    'English': {
      'home': 'Home',
      'dashboard': 'Dashboard',
      'profile': 'Profile',
      'cart': 'Cart',
      'orders': 'Orders',
      'assistant': 'Assistant',
      'shop': 'Shop',
      'auctions': 'Auctions',
      'tools': 'Tools',
      'community': 'Community',
      'verified': 'Verified',
      'selectLanguage': 'Select Language',
      'changeLanguage': 'Change Language',
    },
    'हिंदी': {
      'home': 'होम',
      'dashboard': 'डैशबोर्ड',
      'profile': 'प्रोफाइल',
      'cart': 'कार्ट',
      'orders': 'ऑर्डर',
      'assistant': 'सहायक',
      'shop': 'दुकान',
      'auctions': 'नीलामी',
      'tools': 'उपकरण',
      'community': 'समुदाय',
      'verified': 'सत्यापित',
      'selectLanguage': 'भाषा चुनें',
      'changeLanguage': 'भाषा बदलें',
    },
    'ಕನ್ನಡ': {
      'home': 'ಮುಖಪುಟ',
      'dashboard': 'ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
      'profile': 'ಪ್ರೊಫೈಲ್',
      'cart': 'ಕಾರ್ಟ್',
      'orders': 'ಆದೇಶಗಳು',
      'assistant': 'ಸಹಾಯಕ',
      'shop': 'ಅಂಗಡಿ',
      'auctions': 'ಹರಾಜುಗಳು',
      'tools': 'ಉಪಕರಣಗಳು',
      'community': 'ಸಮುದಾಯ',
      'verified': 'ಪರಿಶೀಲಿಸಲಾಗಿದೆ',
      'selectLanguage': 'ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',
      'changeLanguage': 'ಭಾಷೆ ಬದಲಾಯಿಸಿ',
    },
  };
  
  // Customer-specific translations
  final Map<String, Map<String, String>> _customerTranslations = {
    'English': {
      'appTitle': 'Farmer Future Connect',
      'welcomeTitle': 'Fresh From The Farm!',
      'welcomeSubtitle': 'Get the best quality produce delivered to your doorstep.',
      'shopByCategory': 'Shop by Category',
      'featuredProducts': 'Featured Products',
      'viewAll': 'View All',
      'addToCart': 'Add to Cart',
      'by': 'By',
      'cartScreenTitle': 'Your Shopping Cart',
      'cartScreenEmpty': 'Your cart is empty. Start shopping to add items!',
      'ordersScreenTitle': 'Your Orders',
      'ordersScreenEmpty': 'No orders yet. Place your first order to see it here!',
    },
    'हिंदी': {
      'appTitle': 'किसान भविष्य कनेक्ट',
      'welcomeTitle': 'खेत से ताजा!',
      'welcomeSubtitle': 'सबसे अच्छी गुणवत्ता वाले उत्पाद अपने घर तक पहुंचाए जाते हैं।',
      'shopByCategory': 'श्रेणी के अनुसार खरीदारी करें',
      'featuredProducts': 'विशेष उत्पाद',
      'viewAll': 'सभी देखें',
      'addToCart': 'कार्ट में जोड़ें',
      'by': 'द्वारा',
      'cartScreenTitle': 'आपकी शॉपिंग कार्ट',
      'cartScreenEmpty': 'आपकी कार्ट खाली है। आइटम जोड़ने के लिए शॉपिंग शुरू करें!',
      'ordersScreenTitle': 'आपके ऑर्डर',
      'ordersScreenEmpty': 'अभी तक कोई ऑर्डर नहीं। अपना पहला ऑर्डर देखने के लिए ऑर्डर करें!',
    },
    'ಕನ್ನಡ': {
      'appTitle': 'ರೈತ ಭವಿಷ್ಯ ಕನೆಕ್ಟ್',
      'welcomeTitle': 'ಕೃಷಿ ಕ್ಷೇತ್ರದಿಂದ ತಾಜಾ!',
      'welcomeSubtitle': 'ಅತ್ಯುತ್ತಮ ಗುಣಮಟ್ಟದ ಉತ್ಪನ್ನಗಳನ್ನು ನಿಮ್ಮ ಮನೆಬಾಗಿಲಿಗೆ ತಲುಪಿಸಲಾಗುತ್ತದೆ.',
      'shopByCategory': 'ವರ್ಗದ ಪ್ರಕಾರ ಶಾಪಿಂಗ್ ಮಾಡಿ',
      'featuredProducts': 'ವಿಶೇಷ ಉತ್ಪನ್ನಗಳು',
      'viewAll': 'ಎಲ್ಲವನ್ನೂ ನೋಡಿ',
      'addToCart': 'ಕಾರ್ಟ್‌ಗೆ ಸೇರಿಸಿ',
      'by': 'ಮೂಲಕ',
      'cartScreenTitle': 'ನಿಮ್ಮ ಶಾಪಿಂಗ್ ಕಾರ್ಟ್',
      'cartScreenEmpty': 'ನಿಮ್ಮ ಕಾರ್ಟ್ ಖಾಲಿಯಾಗಿದೆ. ವಸ್ತುಗಳನ್ನು ಸೇರಿಸಲು ಶಾಪಿಂಗ್ ಪ್ರಾರಂಭಿಸಿ!',
      'ordersScreenTitle': 'ನಿಮ್ಮ ಆದೇಶಗಳು',
      'ordersScreenEmpty': 'ಇನ್ನೂ ಯಾವುದೇ ಆದೇಶಗಳಿಲ್ಲ. ಇಲ್ಲಿ ನೋಡಲು ನಿಮ್ಮ ಮೊದಲ ಆದೇಶವನ್ನು ನೀಡಿ!',
    },
  };
  
  // Farmer-specific translations
  final Map<String, Map<String, String>> _farmerTranslations = {
    'English': {
      'appTitle': 'Farmer Dashboard',
      'welcomeBack': 'Welcome back,',
      'verifiedFarmer': 'Verified Farmer',
      'todaysWeather': 'Today\'s Weather',
      'marketPrices': 'Market Prices',
      'activeAuctions': 'Active Auctions',
      'cropCalendar': 'Crop Calendar',
      'yourCrops': 'Your Crops',
      'createAuction': 'Create Auction',
      'viewCalendar': 'View Calendar',
      'nearbyVendors': 'Nearby Vendors',
      'quickTools': 'Quick Tools',
    },
    'हिंदी': {
      'appTitle': 'किसान डैशबोर्ड',
      'welcomeBack': 'वापस स्वागत है,',
      'verifiedFarmer': 'सत्यापित किसान',
      'todaysWeather': 'आज का मौसम',
      'marketPrices': 'बाजार भाव',
      'activeAuctions': 'सक्रिय नीलामी',
      'cropCalendar': 'फसल कैलेंडर',
      'yourCrops': 'आपकी फसलें',
      'createAuction': 'नीलामी बनाएं',
      'viewCalendar': 'कैलेंडर देखें',
      'nearbyVendors': 'आस-पास के विक्रेता',
      'quickTools': 'त्वरित उपकरण',
    },
    'ಕನ್ನಡ': {
      'appTitle': 'ರೈತ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
      'welcomeBack': 'ಮರಳಿ ಸ್ವಾಗತ,',
      'verifiedFarmer': 'ಪರಿಶೀಲಿಸಲಾದ ರೈತ',
      'todaysWeather': 'ಇಂದಿನ ಹವಾಮಾನ',
      'marketPrices': 'ಮಾರುಕಟ್ಟೆ ಬೆಲೆಗಳು',
      'activeAuctions': 'ಸಕ್ರಿಯ ಹರಾಜುಗಳು',
      'cropCalendar': 'ಬೆಳೆ ಕ್ಯಾಲೆಂಡರ್',
      'yourCrops': 'ನಿಮ್ಮ ಬೆಳೆಗಳು',
      'createAuction': 'ಹರಾಜು ರಚಿಸಿ',
      'viewCalendar': 'ಕ್ಯಾಲೆಂಡರ್ ವೀಕ್ಷಿಸಿ',
      'nearbyVendors': 'ಹತ್ತಿರದ ಮಾರಾಟಗಾರರು',
      'quickTools': 'ತ್ವರಿತ ಉಪಕರಣಗಳು',
    },
  };
  
  // Vendor-specific translations
  final Map<String, Map<String, String>> _vendorTranslations = {
    'English': {
      'appTitle': 'Vendor Dashboard',
      'businessProfile': 'Business Profile',
      'activeBids': 'Active Bids',
      'wonAuctions': 'Won Auctions',
      'rating': 'Rating',
      'yourRecentBids': 'Your Recent Bids',
      'nearbyAuctions': 'Nearby Auctions',
      'verified': 'Verified',
      'highest': 'Highest',
      'outbid': 'Outbid',
      'viewAll': 'View All',
      'noBids': 'No bids placed yet.',
      'noAuctions': 'No nearby auctions found.',
    },
    'हिंदी': {
      'appTitle': 'विक्रेता डैशबोर्ड',
      'businessProfile': 'व्यापार प्रोफाइल',
      'activeBids': 'सक्रिय बोलियां',
      'wonAuctions': 'जीती हुई नीलामियां',
      'rating': 'रेटिंग',
      'yourRecentBids': 'आपकी हालिया बोलियां',
      'nearbyAuctions': 'आस-पास की नीलामियां',
      'verified': 'सत्यापित',
      'highest': 'सबसे ऊंची',
      'outbid': 'बाहर बोली',
      'viewAll': 'सभी देखें',
      'noBids': 'अभी तक कोई बोली नहीं लगाई गई है।',
      'noAuctions': 'आस-पास कोई नीलामी नहीं मिली।',
    },
    'ಕನ್ನಡ': {
      'appTitle': 'ಮಾರಾಟಗಾರ ಡ್ಯಾಶ್‌ಬೋರ್ಡ್',
      'businessProfile': 'ವ್ಯಾಪಾರ ಪ್ರೊಫೈಲ್',
      'activeBids': 'ಸಕ್ರಿಯ ಬಿಡ್‌ಗಳು',
      'wonAuctions': 'ಗೆದ್ದ ಹರಾಜುಗಳು',
      'rating': 'ರೇಟಿಂಗ್',
      'yourRecentBids': 'ನಿಮ್ಮ ಇತ್ತೀಚಿನ ಬಿಡ್‌ಗಳು',
      'nearbyAuctions': 'ಹತ್ತಿರದ ಹರಾಜುಗಳು',
      'verified': 'ಪರಿಶೀಲಿಸಲಾಗಿದೆ',
      'highest': 'ಅತ್ಯಧಿಕ',
      'outbid': 'ಔಟ್‌ಬಿಡ್',
      'viewAll': 'ಎಲ್ಲವನ್ನೂ ನೋಡಿ',
      'noBids': 'ಇನ್ನೂ ಯಾವುದೇ ಬಿಡ್‌ಗಳನ್ನು ಮಾಡಿಲ್ಲ.',
      'noAuctions': 'ಹತ್ತಿರದ ಯಾವುದೇ ಹರಾಜುಗಳು ಕಂಡುಬಂದಿಲ್ಲ.',
    },
  };
  
  // Getters
  String get currentLanguage => _currentLanguage;
  
  // Setters
  set currentLanguage(String language) {
    if (supportedLanguages.contains(language)) {
      _currentLanguage = language;
      notifyListeners();
    }
  }
  
  // Methods to get translations
  String getCommonText(String key) {
    return _commonTranslations[_currentLanguage]?[key] ?? 
           _commonTranslations['English']![key] ?? 
           '[$key]';
  }
  
  String getCustomerText(String key) {
    // Try customer-specific translations first, fall back to common
    return _customerTranslations[_currentLanguage]?[key] ?? 
           getCommonText(key);
  }
  
  String getFarmerText(String key) {
    // Try farmer-specific translations first, fall back to common
    return _farmerTranslations[_currentLanguage]?[key] ?? 
           getCommonText(key);
  }
  
  String getVendorText(String key) {
    // Try vendor-specific translations first, fall back to common
    return _vendorTranslations[_currentLanguage]?[key] ?? 
           getCommonText(key);
  }
  
  // Widget for language selection
  Widget buildLanguageSelector({
    required BuildContext context,
    required Function(String) onLanguageSelected,
    bool isInAppBar = false,
  }) {
    if (isInAppBar) {
      return PopupMenuButton<String>(
        icon: const Icon(Icons.language, color: Colors.white),
        tooltip: getCommonText('changeLanguage'),
        onSelected: (String language) {
          onLanguageSelected(language);
        },
        itemBuilder: (BuildContext context) {
          return supportedLanguages.map((String language) {
            return PopupMenuItem<String>(
              value: language,
              child: Row(
                children: [
                  if (_currentLanguage == language)
                    const Icon(Icons.check, size: 18, color: Colors.green)
                  else
                    const SizedBox(width: 18),
                  const SizedBox(width: 10),
                  Text(language),
                ],
              ),
            );
          }).toList();
        },
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language / भाषा चुनें / ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: supportedLanguages.map((language) => 
                ElevatedButton(
                  onPressed: () {
                    onLanguageSelected(language);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentLanguage == language 
                      ? Colors.blue.shade700 
                      : Colors.white,
                    foregroundColor: _currentLanguage == language 
                      ? Colors.white 
                      : Colors.blue.shade700,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(language),
                )
              ).toList(),
            ),
          ],
        ),
      );
    }
  }
} 