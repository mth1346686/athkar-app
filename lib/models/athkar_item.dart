enum AthkarCategory { morning, evening }

class AthkarItem {
  final String id;
  final String title;
  final String text;
  final String fadl;
  final int targetCount;
  int currentCount;
  final AthkarCategory category;

  AthkarItem({
    required this.id,
    required this.title,
    required this.text,
    required this.fadl,
    required this.targetCount,
    this.currentCount = 0,
    required this.category,
  });

  bool get isCompleted => currentCount >= targetCount;
  double get progress => targetCount > 0 ? (currentCount / targetCount).clamp(0.0, 1.0) : 0.0;

  void increment() {
    if (currentCount < targetCount) {
      currentCount++;
    }
  }

  void reset() {
    currentCount = 0;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'currentCount': currentCount,
  };
}
