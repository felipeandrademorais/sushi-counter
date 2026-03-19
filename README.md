# 🍣 Sushi Counter App
### *The Ultimate "Serial Sushi Killer" Companion*

[![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg?style=flat-square)](https://developer.apple.com/swift/)
[![SwiftData](https://img.shields.io/badge/Persistence-SwiftData-blue.svg?style=flat-square)](https://developer.apple.com/xcode/swiftdata/)
[![iOS](https://img.shields.io/badge/iOS-17.0+-black.svg?style=flat-square)](https://www.apple.com/ios/)

A high-end, aesthetically pleasing iOS application designed for the modern sushi enthusiast. This isn't just a counter; it's a statement. Built with a unique **Flat Doodle Aesthetic** and a robust **SwiftData** backend, it tracks your "sushi killing" sessions with style and humor.

---

## 🎨 Design Philosophy & UX

| Aspect | Description |
| :--- | :--- |
| **Flat Doodle Aesthetic** | A bespoke visual identity featuring hand-drawn stroke patterns (3pt), solid hard shadows (radius 0), and a warm off-white canvas (`#F9F7F2`) with subtle dot-pattern overlays. |
| **Serial Sushi Killer Logic** | Gamified deletion experience. Deleting items triggers humorous "Serial Killer" messages, acknowledging your absolute dominance over the buffet. |
| **Floating Responsive Header** | A dynamic Hero Card featuring a giant `96pt` rounded counter that scales and updates with smooth `.spring()` animations and haptic feedback. |

---

## 🛠 Tech Stack

| Technology | Role |
| :--- | :--- |
| **SwiftUI** | Declarative UI framework for responsive and fluid components. |
| **SwiftData** | Modern persistence layer managing the `SushiItem` model with schema-driven safety. |
| **Haptics (UIKit)** | Granular feedback via `UIImpactFeedbackGenerator` for a tactile "clicky" feel. |
| **Canvas API** | Low-level drawing used for the high-performance background dot pattern. |
| **AppStorage** | Lightweight state management for tracking global statistics like deletion streaks. |

---

## 🏗 Senior Architecture

The project follows a clean, **Modular Design** pattern to ensure scalability and maintainability:

- **📦 Models**: Centralized `SushiItem` definition. Using `@Model` from SwiftData allows for automatic schema migration and seamless CloudKit integration.
- **🧱 Components**: Highly reusable UI atoms (e.g., `SushiRowView`, `CustomDeleteModal`) decoupled from business logic.
- **💾 Data**: Constants and static configurations (colors, messages, design tokens) isolated in `AppConstants.swift`.
- **🚀 Logic**: Persistence logic is handled via `modelContext`, ensuring atomic updates and thread-safe data handling.

### Why SwiftData?
We chose SwiftData to eliminate boilerplate. By leveraging macro-based declarations, we achieve complex persistence with minimal code, allowing the CPU to focus on rendering those beautiful `.spring()` animations rather than managing SQL queries.

---

## ✨ Features

- [x] **Smart Increment/Decrement**: Tactile controls with haptic feedback.
- [x] **Dynamic Seed Data**: Automatically populates the menu (Nigiri, Sashimi, Joe, etc.) on first launch.
- [x] **Persistent Stats**: Your progress is saved even if you close the app in a "sushi coma".
- [x] **Custom Modals**: Hand-crafted delete confirmation with personality.
- [x] **Global Reset**: One-tap "Fresh Start" for your next visit to the restaurant.

---

## 🚀 Getting Started

### Prerequisites
- **Xcode 15.0+**
- **iOS 17.0+** (Physical device or Simulator)
- **Swift 5.9+**

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/sushi-couter-app.git
   ```
2. Open `sushi-couter-app.xcodeproj` in Xcode.
3. Ensure the target is set to an **iOS 17.0** device/simulator.
4. Press `Cmd + R` to Build and Run.

---

## 📄 License
This project is for demonstration purposes. Feel free to use the logic and design system for your own "sushi-killing" adventures.
