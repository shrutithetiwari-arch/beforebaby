import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provider for initializing Hive local database
final hiveInitProvider = FutureProvider<void>((ref) async {
  await Hive.initFlutter();
  
  // Open boxes for different modules
  await Hive.openBox('userPrefs');
  await Hive.openBox('healthData');
  await Hive.openBox('relationshipData');
  await Hive.openBox('parentingData');
  await Hive.openBox('financeData');
});

/// Provider for Hive user preferences box
final userPrefsBoxProvider = Provider<Box>((ref) {
  return Hive.box('userPrefs');
});

/// Provider for Hive health data box
final healthDataBoxProvider = Provider<Box>((ref) {
  return Hive.box('healthData');
});

/// Provider for Hive relationship data box
final relationshipDataBoxProvider = Provider<Box>((ref) {
  return Hive.box('relationshipData');
});

/// Provider for Hive parenting data box
final parentingDataBoxProvider = Provider<Box>((ref) {
  return Hive.box('parentingData');
});

/// Provider for Hive finance data box
final financeDataBoxProvider = Provider<Box>((ref) {
  return Hive.box('financeData');
});
