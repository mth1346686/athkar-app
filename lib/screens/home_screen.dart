import 'package:flutter/material.dart';
import '../models/athkar_item.dart';
import '../data/athkar_data.dart';
import '../services/daily_service.dart';
import 'athkar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<AthkarItem> _morningItems;
  late List<AthkarItem> _eveningItems;
  bool _isLoading = true;
  int _streak = 1;
  String _todayDate = '';

  @override
  void initState() {
    super.initState();
    _morningItems = AthkarData.getMorningAdhkar();
    _eveningItems = AthkarData.getEveningAdhkar();
    _initializeDailyData();
  }

  Future<void> _initializeDailyData() async {
    setState(() => _isLoading = true);
    final allItems = [..._morningItems, ..._eveningItems];
    await DailyService.checkAndRenewDaily(allItems);
    final streak = await DailyService.getStreak();
    setState(() {
      _streak = streak;
      _todayDate = DailyService.getTodayKey();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F19),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF10B981)),
        ),
      );
    }

    final morningCompleted = _morningItems.where((i) => i.isCompleted).length;
    final eveningCompleted = _eveningItems.where((i) => i.isCompleted).length;
    final isMorningTime = DateTime.now().hour < 12;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: const Text(
          "أذكار المسلم اليومية",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF131C31),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _initializeDailyData,
        color: const Color(0xFF10B981),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Daily Renewal & Streak Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF131C31), Color(0xFF1E293B)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.sync, color: Color(0xFF10B981), size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bolt, color: Color(0xFFF59E0B), size: 16),
                              const SizedBox(width: 4),
                              Text(
                                "تتابع يومي: $_streak أيام متتالية",
                                style: const TextStyle(
                                  color: Color(0xFFF59E0B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "متجدد تلقائياً لتاريخ اليوم: $_todayDate",
                            style: const TextStyle(
                              color: Color(0xFFF8FAFC),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "تتجدد العدادات تلقائياً مع بداية كل يوم جديد",
                            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Morning Adhkar Card
              _buildCategoryCard(
                title: "أذكار الصباح",
                subtitle: "حصنك الحصين لبداية يوم مبارك",
                icon: Icons.wb_sunny_rounded,
                iconColor: const Color(0xFFF59E0B),
                gradient: const [Color(0xFF1B2A4A), Color(0xFF162035)],
                completed: morningCompleted,
                total: _morningItems.length,
                isRecommended: isMorningTime,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AthkarScreen(
                        title: "أذكار الصباح",
                        items: _morningItems,
                        category: AthkarCategory.morning,
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),

              // Evening Adhkar Card
              _buildCategoryCard(
                title: "أذكار المساء",
                subtitle: "طمأنينة القلب وسكينة المساء وحفظ الليل",
                icon: Icons.nightlight_round,
                iconColor: const Color(0xFF818CF8),
                gradient: const [Color(0xFF1E1E38), Color(0xFF14142B)],
                completed: eveningCompleted,
                total: _eveningItems.length,
                isRecommended: !isMorningTime,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AthkarScreen(
                        title: "أذكار المساء",
                        items: _eveningItems,
                        category: AthkarCategory.evening,
                      ),
                    ),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),

              // Daily Quranic / Sunnah Reflection Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131C31),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF2DD4BF).withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.format_quote, color: Color(0xFF2DD4BF), size: 18),
                        SizedBox(width: 6),
                        Text(
                          "أَلا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
                          style: TextStyle(
                            color: Color(0xFF2DD4BF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "احرص على المحافظة على وردك اليومي من الأذكار صباحاً ومساءً؛ فهو حرز من كل سوء ونور يضيء دربك.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF94A3B8).withOpacity(0.9),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required List<Color> gradient,
    required int completed,
    required int total,
    required bool isRecommended,
    required VoidCallback onTap,
  }) {
    final progress = total > 0 ? completed / total : 0.0;
    final isDone = completed == total;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isRecommended ? const Color(0xFF10B981) : const Color(0xFF334155),
            width: isRecommended ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "الوقت الحالي",
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Progress Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDone ? "مكتمل بالكامل ✨" : "المكتمل: $completed من $total",
                  style: TextStyle(
                    color: isDone ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: const TextStyle(
                    color: Color(0xFF2DD4BF),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: const Color(0xFF1E293B),
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDone ? const Color(0xFF10B981) : const Color(0xFF0D9488),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
