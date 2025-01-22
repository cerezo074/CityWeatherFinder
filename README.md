# CityWeatherFinder

## 📌 Overview
WeatherApp is an iOS application designed to provide real-time weather updates for different cities. Users can search for cities, view current weather details, and save a city when they tap on a suggested city for quick access later.

## 🌟 Features
- 🌍 **City Search**: Allows users to search for a city and retrieve relevant weather data.
- 🌡 **Current Weather Display**: Shows temperature, humidity, UV index, and other weather conditions.
- 📌 **City Saving**: When a user taps on a suggested city, it is saved for later access.
- 📊 **Detailed City View**: Displays comprehensive weather information for a selected city.

## 🏗 Project Architecture & Technologies

### 🔹 Architecture
The project is structured into multiple layers to ensure scalability and maintainability:
- **Core/Services**: Handles dependencies like networking, repositories, and database management.
- **Core/Domain**: Contains use cases that define business logic.
- **Presentation**: Manages UI components, navigation, and MVVM-related ViewModels.
- **Core as a Provider**: The **Core** folder provides necessary components to the **Presentation Layer**, such as **ViewModels** and reusable **UIComponents** that can be used in multiple places across the app.

### 🔹 Technologies Used
The app leverages modern iOS development technologies, including:
- **Swift 5.9**
- **SwiftUI** for UI development
- **SwiftData** for persisting data on disk
- **Swift Concurrency (async/await)** for efficient networking
- **Combine** for reactive programming
- **Kingfisher** for image caching and loading
- **Unit Testing with Swift Testing frameworks**
- **MVVM-C architecture** for clear separation of concerns
- **Clean Architecture & SOLID principles**
- **Background Workers**: All non-UI operations rely on background workers using **Swift Concurrency** to keep the UI responsive at all times.

### 🔹 Future Improvements
- **Image Handling**: Currently, images from the server arrive in a tiny version; we may need to adjust how we request or display higher-resolution images.
- **Error Handling**: While errors are received from the API, the app currently displays a general error message. We should implement more detailed and user-friendly UI error messages.

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- iOS 17+
- Swift Package Manager for dependencies

### Installation
1. Clone the repository and open it in Xcode:
2. **Set up the Weather API Key**:
- Go to **Product** → **Scheme** → **Edit Scheme**.
- Under the **Run** section, select the **Arguments** tab.
- Add a new **Environment Variable** with the key: `WEATHER_API_KEY` and set your API key as the value.

3. Build and run the project on a simulator or real device.

## 📌 Contribution
Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to create a pull request.

## 📜 License
This project is licensed under the MIT License.
