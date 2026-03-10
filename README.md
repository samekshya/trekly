 Trekly - Nepali Trekking App

Trekly is a mobile application developed using Flutter that helps users discover, explore, and book trekking routes across Nepal. The application provides trekking information, weather updates, booking functionality, and user profile management in a single platform.

The goal of Trekly is to simplify trekking planning by providing reliable information and services directly through a mobile application.

📱 Features

Trekly provides a range of features designed to improve the trekking experience for users.

Browse and explore trekking routes across Nepal

View detailed information about each trek

Book trekking trips directly from the app

Save favorite treks for later

View booking history

Check weather conditions for trekking locations

Upload and manage profile photos

Online and offline connectivity detection

🖥️ App Screens

The application includes 15 main screens:

Splash Screen

Onboarding Screen

Login Screen

Register Screen

Forgot Password Screen

Change Password Screen

Home Screen

Explore Screen

Trek Detail Screen

Booking Screen

My Bookings Screen

Favourites Screen

Profile Screen

Settings Screen

Weather Screen

⚙️ Tech Stack
Frontend

Flutter (Dart)

Clean Architecture

MVVM Design Pattern

State Management

Riverpod 2.6.1

Networking

Dio HTTP Client

Local Storage

Hive

SharedPreferences

Backend

Node.js

Express.js

TypeScript

MongoDB

API

Custom REST API running on:

http://10.0.2.2:5050/api
🏗️ Project Architecture

The application follows Clean Architecture principles to maintain separation of concerns and improve scalability.

lib/
 ├── core
 ├── data
 │   ├── datasource
 │   ├── models
 │   └── repositories
 ├── domain
 │   ├── entities
 │   ├── repositories
 │   └── usecases
 └── presentation
     ├── view
     ├── viewmodel
     └── widgets

This layered structure ensures that the application remains modular, testable, and maintainable.

🧠 Design Pattern

The project uses the MVVM (Model–View–ViewModel) design pattern.

Model – Represents the application data and entities

View – UI components built using Flutter widgets

ViewModel – Handles business logic and state management

This pattern helps separate UI from application logic.

🔄 State Management

Trekly uses Riverpod for state management.

Riverpod provides:

Better dependency management

Improved scalability

Easier testing

Cleaner state handling

📡 Sensors and APIs

The application integrates several mobile features and APIs.

Camera

Used for uploading profile photos using:

image_picker
Connectivity Detection

Detects online/offline status using:

connectivity_plus
Maps

Trekking locations are displayed using:

flutter_map
latlong2
Weather API

Displays weather conditions using a custom backend weather endpoint.

🔐 Authentication

The application supports secure user authentication with:

Login

Registration

Password reset

Change password

Authentication tokens are stored locally using Hive.

💾 Data Storage

Two types of data storage are used:

Local Storage

Hive

SharedPreferences

Used for storing tokens and session data.

Remote Database

MongoDB

Stores:

User accounts

Trek information

Bookings

Favorites

Reviews

🚀 Running the Project
1. Clone the Repository
git clone https://github.com/samekshya/trekly.git
2. Navigate to the Project
cd trekly
3. Install Dependencies
flutter pub get
4. Run the Application
flutter run
🔗 Backend API

The Flutter app connects to a Node.js REST API.

Default API base URL:

http://10.0.2.2:5050/api

Make sure the backend server is running before launching the app.

🧪 Testing

The project includes:

Unit tests

Widget tests

Testing ensures the reliability of business logic and UI components.
