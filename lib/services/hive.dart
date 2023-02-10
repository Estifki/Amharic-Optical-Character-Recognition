import 'package:hive/hive.dart';

class LocalDatabase {
  final List<String> _recentScans = [];
  List<String> get recentScans => [..._recentScans];

  List getRecentScans() {
    try {
      var openBox = Hive.box("RecentScan");
      for (var e in openBox.values) {
        _recentScans.insert(0, e);
      }
      return _recentScans;
    } catch (e) {
      rethrow;
    }
  }

  addToRecentScans(String extractedText) {
    try {
      var openBox = Hive.box("RecentScan");
      openBox.add(extractedText);
    } catch (e) {
      rethrow;
    }
  }

  deleteRecentScans(index) {
    try {
      var openBox = Hive.box("RecentScan");
      openBox.deleteAt(index);
    } catch (e) {
      rethrow;
    }
  }
}
