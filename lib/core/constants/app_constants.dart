/// Core constants for the BeforeBaby application
class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.beforebaby.com';
  static const String apiVersion = 'v1';

  // Onboarding
  static const List<String> targetBabyTimeline = [
    '6 Months',
    '1 Year',
    '2 Years',
    '3 Years',
    'Undecided',
  ];

  static const List<String> relationshipStatus = [
    'Single',
    'Married',
    'Engaged',
    'Partnered',
  ];

  static const List<String> genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  // Readiness Engine
  static const Map<String, double> readinessWeights = {
    'health': 0.25,
    'relationship': 0.20,
    'finance': 0.20,
    'parenting': 0.20,
    'mentalHealth': 0.10,
    'environment': 0.05,
  };

  // Health Module
  static const List<String> healthMetrics = [
    'Weight',
    'BMI',
    'Body Fat',
    'Waist Ratio',
    'Sleep',
    'Activity',
  ];

  // Validation
  static const int minPasswordLength = 8;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Durations
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration debounceDelay = Duration(milliseconds: 500);

  // Local Storage Keys
  static const String userPrefsBox = 'user_prefs';
  static const String healthDataBox = 'health_data';
  static const String relationshipDataBox = 'relationship_data';
  static const String parentingDataBox = 'parenting_data';
  static const String financeDataBox = 'finance_data';
}
