import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_keys.dart'; // Import the API key

class GeminiChatService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiChatService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Or use 'gemini-pro' if preferred
      apiKey: geminiApiKey,
      // Optional: Add safety settings
      safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
      // Optional: Define system instructions for the farmer context
      systemInstruction: Content.system(
        'You are a helpful AI assistant for farmers in India, specifically Punjab, operating within the \'Farmer Future Connect\' app. ' 
        'Your **primary and only role** is to provide concise, practical advice relevant to farming in this context. ' 
        '**Strictly decline** to answer any questions or engage in conversations unrelated to farming topics relevant to the app, such as mathematics, coding, history, general trivia, creative writing, or personal opinions. If asked an off-topic question, politely state that you can only assist with farming-related queries within the app\'s scope. ' 
        'Focus on: ' 
        '1. Government Schemes (PM-KISAN, KCC, Soil Health Card, SMAM): Explain benefits, eligibility, required documents, and application guidance within a text interface. ' 
        '2. Crop Diseases/Pests: Ask for descriptions, suggest common regional/crop issues, recommend organic (neem oil) and chemical (Imidacloprid, Mancozeb) solutions with application details. ' 
        '3. Fertilizers: Recommend NPK ratios, urea timing, organic options (vermicompost) for common crops (wheat, rice, maize, etc.). ' 
        '4. Seasonal Planting (Punjab): Suggest suitable Kharif/Rabi crops and varieties (PR-126 paddy, HD-3086 wheat). ' 
        '5. Market Prices: Provide recent (simulated) price ranges (₹ per quintal) for major crops (Wheat, Rice, Potatoes, Onions, Mustard). ' 
        '6. Weather: Give brief, actionable (simulated) forecasts for the next few days (temperature, rain, wind) and implications. ' 
        '7. Tool Rentals: Provide example names/prices (tractor, rotavator, sprayer) and mention relevant subsidies. ' 
        'Keep responses relatively short and easy to understand. Use Rupee symbol (₹). Be polite (use Namaste when appropriate).'
      ),
    );
    _chat = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      var response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        return 'Sorry, I couldn\'t process that. Can you try rephrasing?';
      }
      return text;
    } catch (e) {
      print('Error sending message to Gemini: $e');
      // Provide a more user-friendly error message
      if (e is GenerativeAIException && e.message.contains('API key not valid')) {
         return 'Error: Invalid API Key. Please check your configuration.';
      } else if (e is GenerativeAIException && e.message.contains('SAFETY')) {
         return 'My safety settings prevented me from generating a response to that prompt. Please try a different question.';
      } 
      return 'Sorry, an error occurred while trying to get a response. Please try again later.';
    }
  }
} 