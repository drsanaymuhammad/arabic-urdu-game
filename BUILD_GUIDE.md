# قرآنی الفاظ گیم — APK Build Guide
## Complete Step-by-Step Instructions

---

## STEP 1: Install Flutter (one time only)

1. Go to: https://docs.flutter.dev/get-started/install/windows
2. Download Flutter SDK → Extract to `C:\flutter`
3. Add `C:\flutter\bin` to your System PATH
4. Download & install Android Studio from: https://developer.android.com/studio
5. In Android Studio → SDK Manager → Install:
   - Android SDK (API 33 or 34)
   - Android SDK Build-Tools
6. Run in Command Prompt to verify:
   ```
   flutter doctor
   ```
   All checkmarks should be green ✅

---

## STEP 2: Get the Noori Nastaleeq Font

The app uses **Nafees Nastaleeq** (free Noori Nastaleeq style font):

1. Download from: https://www.cle.org.pk/software/localization/Fonts/nafeesNastaleeq.ttf
   OR search: "Nafees Nastaleeq font free download"
2. Rename the file to: `NafeesNastaleeq.ttf`
3. Place it inside the folder:
   ```
   arabic_urdu_game/assets/fonts/NafeesNastaleeq.ttf
   ```

---

## STEP 3: Set Up the Project

1. Extract the zip file you downloaded
2. Open Command Prompt / Terminal
3. Navigate to the project folder:
   ```
   cd path\to\arabic_urdu_game
   ```
4. Run:
   ```
   flutter pub get
   ```
   This downloads all dependencies (share_plus, shared_preferences, etc.)

---

## STEP 4: Test on Your Phone (optional but recommended)

1. On your Android phone: Settings → Developer Options → Enable USB Debugging
2. Connect phone via USB
3. Run:
   ```
   flutter run
   ```
   The app will install and open on your phone!

---

## STEP 5: Build the APK

Run this command:
```
flutter build apk --release
```

Your APK will be at:
```
build\app\outputs\flutter-apk\app-release.apk
```

**That's your APK file!** Send it to your phone via WhatsApp or USB and install it.

---

## STEP 6: Install APK on Android Phone

1. Send `app-release.apk` to your phone (WhatsApp, email, USB)
2. On phone: Settings → Security → Allow "Install from Unknown Sources"
3. Tap the APK file → Install

---

## Features in Your App

✅ 10 Levels × 8 Quranic words = 80 words total
✅ Noori Nastaleeq Urdu font
✅ All words from your PDF (Surah Maryam to Surah Al-Ahqaf)
✅ 4 MCQ options per word (shuffled every time)
✅ Green/Red feedback on answers
✅ Level locking (complete level 1 to unlock level 2)
✅ Score saved permanently
✅ ⭐⭐⭐ Star rating after each level
✅ Share score to WhatsApp, Instagram, and any other app
✅ Full Urdu RTL interface
✅ Works offline (no internet needed)

---

## Sharing Feature

After each level, you'll see 3 share buttons:
- **WhatsApp** 🟢 — Opens WhatsApp share sheet with your score
- **Instagram** 📷 — Opens Instagram (copy text to story caption)
- **دیگر** — Opens system share sheet for any other app

The share message will look like:
```
📖 قرآنی الفاظ گیم — میرا نتیجہ!

⭐⭐⭐
Level 1: سُوۡرَةُ مَرۡيَم
Score: 8/8 (100%)
شاندار! مکمل اسکور!

🕋 کیا آپ بھی یہ گیم کھیلنا چاہتے ہیں؟
```

---

## Troubleshooting

**"flutter not recognized"** → Make sure Flutter is added to PATH and restart terminal

**"Android SDK not found"** → Open Android Studio → SDK Manager → Install Android SDK

**Font not showing correctly** → Make sure NafeesNastaleeq.ttf is in `assets/fonts/` folder

**App installs but crashes** → Run `flutter run` with USB connected to see error logs

---

Need help? The full Flutter documentation is at: https://docs.flutter.dev
