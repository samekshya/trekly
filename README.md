Trekly - Trek Discovery & Booking Mobile App

Trekly is a mobile application designed to help users discover and book trekking adventures in Nepal. The app allows users to explore trekking routes, view detailed trek information, check weather conditions, save favourite treks, and book trekking trips directly from their mobile device.

This project was developed as part of the Mobile Application Development (ST6002CEM) module at Softwarica College / Coventry University.

Features

User authentication (Login / Register)

Trek discovery and browsing

Detailed trek information

Weather information integration

Save favourite treks

Trek booking functionality

Responsive UI for phone and tablet

Image upload functionality

Internet connectivity detection

Automated unit and widget testing

Tech Stack
Frontend

Flutter

Dart

Material UI

Backend

Node.js

Express.js

TypeScript

MongoDB

Architecture

Clean Architecture

MVVM Design Pattern

Project Structure
lib/
 ├── core/
 │   ├── api
 │   ├── config
 │   ├── constants
 │   └── services
 │
 ├── features/
 │   ├── auth
 │   ├── treks
 │   └── upload
 │
 ├── screens/
 │   ├── login
 │   ├── register
 │   ├── dashboard
 │   ├── explore
 │   ├── profile
 │   └── booking
 │
 └── main.dart
Screens Demonstrated

Splash Screen

Onboarding Screen

Login Screen

Register Screen

Dashboard

Explore Treks

Trek Detail Page

Weather Screen

Booking Screen

Profile / Settings

Testing

The project includes automated tests:

Unit Tests

Use case testing

ViewModel testing

Service testing

Widget Tests

Screen UI testing

Interaction testing

Testing tools used:

Flutter Test

Mockito
