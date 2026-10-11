import 'package:flutter/material.dart';
import '../models/athkar_item.dart';
import '../widgets/athkar_card.dart';
import '../services/daily_service.dart';

class AthkarScreen extends StatefulWidget {
  final String title;
  final List<AthkarItem> items;
  final AthkarCategory category;

  const AthkarScreen({
    Key? key,
    required this.title,
    required this.items,
    required this.category,
  }) : super(key: key);

  @override
  State<AthkarScreen> createState() => _AthkarScreenState();
}

class _AthkarScreenState extends State<AthkarScreen> {
  @override
  Widget build(BuildContext context) {
    final completedCount = widget.items.where((i) => i.isCompleted).length;
    final totalCount = widget.items.length;
    final overallProgress = totalCount > 0 ? completedCount / totalCount : 0.0;
    final isAllDone = completedCount == totalCount;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF131C31),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, color: Color(0xFF94A3B8)),
            tooltip: "إعادة تعيين الكل",
            onPressed: () => _confirmResetAll(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Sticky Top Progress Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFF131C31),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isAllDone ? "🎉 أحسنت! أتممت الأذكار بالكامل" : "التقدم في الأذكار",
                      style: TextStyle(
                        color: isAllDone ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "$completedCount من $totalCount مكتمل",
                      style: const TextStyle(
                        color: Color(0xFF2DD4BF),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: overallProgress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFF1E293B),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isAllDone ? const Color(0xFF10B981) : const Color(0xFF0D9488),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Athkar List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return AthkarCard(
                  item: item,
                  onCount: () async {
                    setState(() {
                      item.increment();
                    });
                    await DailyService.saveCount(item);
                    if (widget.items.every((i) => i.isCompleted)) {
                      _showCompletionCelebration();
                    }
                  },
                  onReset: () async {
                    setState(() {
                      item.reset();
                    });
                    await DailyService.saveCount(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmResetAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("إعادة تعيين الأذكار", style: TextStyle(color: Colors.white)),
        content: const Text(
          "هل ترغب في إعادة عدادات هذه المجموعة إلى الصفر؟",
          style: TextStyle(color: Color(0xFF94A3B8)),
        ),
        actions: [
          TextButton(
            child: const Text("إلغاء", style: TextStyle(color: Color(0xFF64748B))),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444)),
            child: const Text("إعادة البدء", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.pop(ctx);
              setState(() {
                for (var item in widget.items) {
                  item.reset();
                }
              });
              for (var item in widget.items) {
                await DailyService.saveCount(item);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showCompletionCelebration() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Row(
          children: [
            Icon(Icons.verified, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "بارك الله فيك! تم إكمال جميع أذكار الورد بنجاح.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
