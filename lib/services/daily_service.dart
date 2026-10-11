import 'package:shared_preferences/shared_preferences.dart';
import '../models/athkar_item.dart';

class DailyService {
  static const String _keyLastDate = 'athkar_last_active_date';
  static const String _keyStreak = 'athkar_daily_streak';
  static const String _prefixThikr = 'thikr_count_';

  /// Returns today's date formatted as YYYY-MM-DD
  static String getTodayKey() {
    final now = DateTime.now();
    return "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  /// Checks if a new day has arrived and resets counters automatically
  static Future<bool> checkAndRenewDaily(List<AthkarItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final today = getTodayKey();
    final lastDate = prefs.getString(_keyLastDate) ?? '';

    bool isNewDay = (lastDate != today);

    if (isNewDay) {
      // Clear saved thikr counts for new day
      for (var item in items) {
        await prefs.remove('${_prefixThikr}${item.id}');
        item.reset();
      }

      // Update streak calculation
      if (lastDate.isNotEmpty) {
        try {
          final lastDateTime = DateTime.parse(lastDate);
          final now = DateTime.now();
          final difference = now.difference(lastDateTime).inDays;
          if (difference == 1) {
            int currentStreak = prefs.getInt(_keyStreak) ?? 1;
            await prefs.setInt(_keyStreak, currentStreak + 1);
          } else if (difference > 1) {
            await prefs.setInt(_keyStreak, 1);
          }
        } catch (_) {
          await prefs.setInt(_keyStreak, 1);
        }
      } else {
        await prefs.setInt(_keyStreak, 1);
      }

      await prefs.setString(_keyLastDate, today);
    } else {
      // Load saved progress for today
      for (var item in items) {
        int savedCount = prefs.getInt('${_prefixThikr}${item.id}') ?? 0;
        item.currentCount = savedCount;
      }
    }

    return isNewDay;
  }

  /// Saves a single thikr count to persistent storage
  static Future<void> saveCount(AthkarItem item) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_prefixThikr}${item.id}', item.currentCount);
    await prefs.setString(_keyLastDate, getTodayKey());
  }

  /// Retrieves current active streak
  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyStreak) ?? 1;
  }
}
