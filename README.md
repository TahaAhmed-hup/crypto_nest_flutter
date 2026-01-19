# Crypto Nest – Flutter App

A Flutter application demonstrating **real-world authentication and verification flows**, built for **portfolio and learning purposes**.

---

## ✨ Features

### 🔐 Authentication & Security
- Email & password authentication
- **Email OTP verification** using Supabase (PostgreSQL)
- OTP expiration & single-use validation
- Secure backend-driven verification flow
- Password reset via email

### 📸 Identity Verification (KYC Flow)
- Government ID upload:
  - National ID
  - Passport
  - Driver’s License
- Selfie photo upload
- Camera & gallery support
- Validation rules similar to real production apps

### 🏠 Home & Portfolio
- Verified user state handling
- Portfolio dashboard
- Empty portfolio states
- Profile data derived from user email
- Demo assets for presentation purposes

### ⚙️ App Structure
- Bottom navigation with Root Page
- Modular feature-based structure
- Reusable custom widgets
- Responsive UI

---

## 🛠 Tech Stack
- **Flutter**
- **Supabase (PostgreSQL)**
- **State Management:** Cubit (`flutter_bloc`)
- **Architecture:** Clean Architecture
- **Image Picker:** Camera & Gallery
- **Environment Config:** `.env` variables

---

## 🚀 Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/TahaAhmed-hup/crypto_nest_flutter.git
cd crypto_nest_flutter
2️⃣ Install dependencies
flutter pub get
3️⃣ Environment variables
Create a .env file in the project root:

SUPABASE_URL=your_supabase_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
⚠️ The .env file is ignored by Git and must not be committed.

4️⃣ Run the app
flutter run
📝 Notes
This project focuses on real production-like flows, not just UI.

OTP verification and KYC flows are implemented end-to-end.

Supabase is used as a backend service for authentication and data handling.

Designed mainly for portfolio demonstration.

👤 Author
Taha Ahmed Fahmy
Flutter Developer

📫 LinkedIn: www.linkedin.com/in/taha-ahmed-developer
💻 GitHub: https://github.com/TahaAhmed-hup