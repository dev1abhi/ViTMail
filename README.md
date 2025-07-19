# ViTMail

Flutter based Mail-Service App made using Gmail API.

# Techstacks used
- Flutter
- Firebase (for getting authentication token for Gmail API)
- Gmail API
- Google Gemini for summarizing mails

# 🛠️ Development Environment

This project was developed and tested in the following environment to ensure consistency across builds and platforms.

---

## 🔧 System Info
- **OS**: Windows 10 (Build 26100.4652)
- **Architecture**: Windows x64
- **Locale**: en-IN

---

## 🐦 Flutter SDK
- **Flutter Version**: 3.24.3 (stable)
- **Channel**: stable
- **Dart Version**: 3.5.3
- **DevTools Version**: 2.37.3
- **Flutter Location**: `C:\src\flutter`

---

## 📱 Android Development
- **Android SDK Version**: 35.0.0
- **Build Tools Version**: 33.0.3
- **NDK Version**: 25.1.8937393
- **Compile SDK**: 34
- **Java Version**: 17.0.12+8-LTS-286
- **Java Path**: `C:\Program Files\Java\jdk-17`
- **Gradle Plugin Version**: 8.2.2
- **Kotlin Version**: 1.9.10
- **Kotlin JVM Target**: 1.8

---

## ⚙️ Java & Kotlin Compile Options (Gradle)

To ensure compatibility and access to desired Java features, make sure your project's `build.gradle` file includes the following:

```groovy
android {
    compileOptions {
        // Java 8 compatibility
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        // Kotlin JVM target version
        jvmTarget = '1.8'
    }
}
```

## 💻 IDE
- **Android Studio Version**: 2024.2 (Giraffe)
- **Location**: `D:\AndroidStudio`
- **Flutter Plugin**: Installed
- **Dart Plugin**: Installed

---

## 🌐 Web & Desktop Development
- **Web Browsers**:
    - Chrome 138.0.7204.158
    - Edge 139.0.3405.42
- **Connected Devices**:
    - AOSP on IA Emulator (Android 9)
    - Windows (desktop)
    - Chrome (web)
    - Edge (web)

---

## 🔧 Troubleshooting

### 1. Configure Specific NDK Version to 25.2.x (tested)

If you're encountering NDK compatibility or build issues, set a specific NDK version as follows:

####  Step 1: Modify `android/build.gradle`

Add this inside the `android` block:

```groovy
android {
    ndkVersion '25.2.9519653' // This had been tested
}
```
### 2. Configure flutter JDK version to jdk-17 (tested)

Tell Flutter to use this JDK:

```groovy
flutter config --jdk-dir="C:\Program Files\Java\jdk-17"
```

To verify:

```groovy
flutter config
```

---


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- Also , Create .env file and add Gemini API KEY to use the summarisation.
