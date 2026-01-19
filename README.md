# Crypto Nest – Flutter App

A Flutter application demonstrating **real-world authentication and verification flows**, built for portfolio and learning purposes.

## ✨ Features

### 🔐 Authentication & Security
- Custom **Email OTP verification** using Supabase (PostgreSQL)
- OTP expiration & single-use validation
- Secure backend-driven verification flow

### 📸 Identity Verification
- Government ID upload (ID / Passport / Driver License)
- Selfie photo upload
- Camera & gallery support
- Real validation rules similar to production apps

### 📊 Portfolio
- Verified user state
- Portfolio dashboard & empty states
- Profile information handling

## 🛠 Tech Stack
- **Flutter**
- **Supabase (PostgreSQL)**
- **State Management:** Cubit (flutter_bloc)
- **Architecture:** Clean Architecture

## 🚀 Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/USERNAME/REPO_NAME.git
cd REPO_NAME
2️⃣ Install dependencies
flutter pub get
3️⃣ Environment variables
Create a .env file in the project root:

SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
⚠️ The .env file is ignored by Git and should not be committed.

4️⃣ Run the app
flutter run

📝 Notes
This project focuses on real production-like flows, not just UI.

Built for portfolio/demo purposes.

Secrets and keys are safely handled using environment variables.

👤 Author
Taha Ahmed Fahmy
Flutter Developer


