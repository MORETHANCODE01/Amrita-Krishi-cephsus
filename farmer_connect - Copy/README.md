# farmer_connect

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

1.  **Flutter SDK:** Ensure you have Flutter installed. Follow the [official guide](https://docs.flutter.dev/get-started/install).
2.  **Gemini API Key:** This project uses the Gemini API for the AI Chatbot feature.
    *   Obtain an API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
    *   Create the file `lib/config/api_keys.dart`.
    *   Inside `api_keys.dart`, add the following line, replacing `"YOUR_GEMINI_API_KEY"` with your actual key:
        ```dart
        const String geminiApiKey = "YAIzaSyD_B8JlmZnZbol35m2zlG2CkyQXqa4PhYo";
        ```
    *   **Important:** Add `lib/config/api_keys.dart` to your `.gitignore` file to avoid committing your key.

### Running the App

1.  Install dependencies:
    ```bash
    flutter pub get
    ```
2.  Run the app (replace `<device_id>` with your target device/emulator ID or `chrome` for web):
    ```bash
    flutter run -d <device_id>
    ```

## Project Structure Overview

*   `lib/`: Contains the main Dart code.
    *   `main.dart`: App entry point.
    *   `config/`: Configuration files (like API keys).
    *   `models/`: (Optional) Data models if separated.
    *   `screens/`: Contains UI screens, organized by user type (farmer, customer, vendor).
    *   `services/`: Contains business logic services (AuctionService, GeminiChatService).
    *   `widgets/`: (Optional) Reusable UI widgets.

## Original Flutter README Content

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
