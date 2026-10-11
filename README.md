# Athkar App | تطبيق أذكار المسلم اليومية

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20Web-green?style=for-the-badge" alt="Platform" />
  <img src="https://img.shields.io/badge/Release-v1.0.1-emerald?style=for-the-badge" alt="Release" />
</p>

---

## 🇬🇧 English Description

### Overview
**Athkar App** is a modern, high-performance Flutter mobile application built for reciting and tracking Morning & Evening Adhkar (**أذكار الصباح والمساء**) with an intelligent **Daily Auto-Renewal Engine**. The application automatically resets all progress counters at midnight every day, maintains streak counts, and persists data across sessions with zero battery drain.

### Key Features
- 🔄 **Daily Auto-Renewal:** Counters automatically reset to zero at midnight for a fresh daily session without manual intervention.
- ⚡ **Streak Tracking:** Tracks your daily consistency (consecutive days) to encourage daily remembrance habits.
- 💾 **Local Offline Persistence:** Instant state saving using `SharedPreferences` ensures your progress is never lost if the app closes.
- 🎨 **Modern Islamic Cyber-Dark UI:** Ergonomic dark palette (Deep Obsidian `#0B0F19`, Emerald `#10B981`, and Amber `#F59E0B`) that is comfortable on the eyes during morning and night recitations.
- 📿 **Interactive Tap Counter:** Radial progress ring around every thikr with celebration feedback upon full completion.
- 📖 **Authentic Text & Tashkeel:** Fully vowelized (تشكيل) Quranic verses and Prophetic Hadiths accompanied by their recorded virtues (*Fadl*).
- 🌐 **100% RTL & Arabic Native:** Tailored specifically for Right-to-Left orientation and Arabic typography.

### Direct APK Download
You can download the pre-compiled Android release APK directly from our GitHub Releases:
- 📲 **[Download Athkar.apk (v1.0.1)](https://github.com/mth1346686/athkar-app/releases/download/v1.0.1/app-release.apk)**

### Getting Started & Running Locally

1. **Prerequisites:**
   - Flutter SDK (>= 3.24.0)
   - Android SDK / Java 17

2. **Clone & Setup:**
   ```bash
   git clone https://github.com/mth1346686/athkar-app.git
   cd athkar-app
   flutter pub get
   ```

3. **Run on Device / Emulator:**
   ```bash
   flutter run
   ```

4. **Build Release APK:**
   ```bash
   flutter build apk --release --no-tree-shake-icons
   ```

---

## 🇸🇦 الوصف باللغة العربية (Arabic Description)

### نبذة عن التطبيق
**تطبيق الأذكار (Athkar App)** هو تطبيق فلاتر عصري ومتكامل مخصص لقراءة وتتبع أذكار الصباح والمساء، مزود بمحرك **تجدد تلقائي يومي ذكي**. يقوم التطبيق بإعادة ضبط وتصفير عدادات الأذكار تلقائياً عند بداية كل يوم جديد في منتصف الليل، مع احتساب أيام المداومة المتتالية وحفظ التقدم لحظياً دون استهلاك البطارية.

### المميزات الرئيسية
- 🔄 **تجدد يومي تلقائي (Daily Auto-Renewal):** تتصفر جميع العدادات تلقائياً مع بداية كل يوم جديد بدون الحاجة لأي تدخل يدوي.
- ⚡ **تتبع التتابع اليومي (Streak Counter):** عداد ذكي يحسب عدد الأيام المتتالية التي تحافظ فيها على وردك اليومي لتحفيز الاستمرار.
- 💾 **حفظ فوري بدون إنترنت:** يتم حفظ تقدم كل ذكر بشكل فوري في الذاكرة المحلية عبر `SharedPreferences`.
- 🎨 **واجهة إسلامية داكنة وفخمة (Modern Dark Theme):** ألوان مريحة للعين في الصباح الباكر وسكون الليل (كحلي أوبسيديان داكن مع لمسات الزمرد والذهب).
- 📿 **عداد تسبيح تفاعلي:** زر عداد تفاعلي سلس مع حلقة تقدم دائرية وإشعار احتفالي عند إتمام الورد كاملاً.
- 📖 **نصوص موثقة ومشكلة بالكامل:** آيات قرآنية وأحاديث نبوية صحيحة مشكولة بالكامل مع ذكر فضل كل ذكر وأجره.
- 🌐 **دعم كامل للغة العربية (RTL):** تصميم مخصص بالكامل للاتجاه من اليمين إلى اليسار مع خطوط عربية واضحة وأنيقة.

### تحميل تطبيق الأندرويد مباشرة (APK)
يمكنك تحميل النسخة الرسمية الجاهزة للتثبيت المباشر على هاتفك من صفحة الإصدارات:
- 📲 **[تحميل ملف Athkar.apk (الإصدار v1.0.1)](https://github.com/mth1346686/athkar-app/releases/download/v1.0.1/app-release.apk)**

### طريقة التشغيل والتطوير المحلي

1. **المتطلبات:**
   - بيئة Flutter SDK (>= 3.24.0)
   - بيئة Android SDK / Java 17

2. **تنزيل المشروع وتثبيت الحزم:**
   ```bash
   git clone https://github.com/mth1346686/athkar-app.git
   cd athkar-app
   flutter pub get
   ```

3. **التشغيل على الهاتف أو المحاكي:**
   ```bash
   flutter run
   ```

4. **بناء ملف APK نهائي:**
   ```bash
   flutter build apk --release --no-tree-shake-icons
   ```

---

## 📂 Project Architecture | هيكلية المشروع

```
athkar_app/
├── .github/
│   └── workflows/
│       └── build.yml             # GitHub Actions CI/CD to build APK
├── lib/
│   ├── data/
│   │   └── athkar_data.dart      # Verified Morning & Evening Adhkar datasets
│   ├── models/
│   │   └── athkar_item.dart      # Thikr data model & calculation logic
│   ├── screens/
│   │   ├── athkar_screen.dart    # Category recitation & interactive counter UI
│   │   └── home_screen.dart      # Dashboard with streaks & daily auto-renewal
│   ├── services/
│   │   └── daily_service.dart    # Calendar date watcher & midnight reset engine
│   ├── widgets/
│   │   └── athkar_card.dart      # Interactive thikr card & progress rings
│   └── main.dart                 # App entry point & Material 3 Dark RTL Theme
├── pubspec.yaml                  # Flutter package dependencies
└── README.md                     # Bilingual Documentation
```

---

## 📜 License | الترخيص
This project is open-source and dedicated as an ongoing charity (صدقة جارية). Feel free to use, modify, and distribute it.
