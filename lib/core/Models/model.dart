import 'dart:io';

class HistoryItem {
  final File image;
  final String diseaseName;
  final DateTime date;

  HistoryItem({
    required this.image,
    required this.diseaseName,
    required this.date,
  });
}

class HistoryManager {
  static final List<HistoryItem> _historyItems = [];

  static List<HistoryItem> get historyItems => _historyItems;

  static void addHistoryItem(HistoryItem item) {
    _historyItems.add(item);
  }

  static void clearHistory() {
    _historyItems.clear();
  }
}