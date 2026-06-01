import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadinessScoreCard extends StatelessWidget {
  final String title;
  final double score;
  final String category;
  final IconData icon;
  final Color color;

  const ReadinessScoreCard({
    Key? key,
    required this.title,
    required this.score,
    required this.category,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          category,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(score * 100).toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/ 100',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: score,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardDetailPage extends ConsumerWidget {
  const DashboardDetailPage({Key? key}) : super(key: key);

  Color _getScoreColor(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.orange;
    if (score >= 0.4) return Colors.amber;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scores = {
      'Health': 0.72,
      'Relationship': 0.65,
      'Finance': 0.58,
      'Parenting': 0.70,
      'Mental Health': 0.75,
      'Environment': 0.85,
    };

    final icons = {
      'Health': Icons.health_and_safety,
      'Relationship': Icons.favorite,
      'Finance': Icons.attach_money,
      'Parenting': Icons.child_care,
      'Mental Health': Icons.psychology,
      'Environment': Icons.nature,
    };

    final categories = {
      'Health': 'Physical wellness & fitness',
      'Relationship': 'Partner relationship quality',
      'Finance': 'Financial stability',
      'Parenting': 'Parenting skills & knowledge',
      'Mental Health': 'Emotional wellbeing',
      'Environment': 'Living environment',
    };

    double overallScore = scores.values.fold(0, (sum, value) => sum + value) / scores.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Readiness Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Score Card
            Card(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overall Readiness',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${(overallScore * 100).toStringAsFixed(0)}',
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '/ 100',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'You are',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Well Prepared',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: overallScore,
                        minHeight: 10,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Category Breakdown',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...scores.entries.map((entry) {
              final title = entry.key;
              final score = entry.value;
              final color = _getScoreColor(score);
              final icon = icons[title] ?? Icons.help;
              final category = categories[title] ?? '';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ReadinessScoreCard(
                  title: title,
                  score: score,
                  category: category,
                  icon: icon,
                  color: color,
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            Text(
              'Recommendations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              context,
              'Improve Financial Stability',
              'Your financial readiness score is lower than other areas. Consider building an emergency fund.',
              Icons.trending_up,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              context,
              'Strengthen Communication',
              'Regular couple communication exercises can help strengthen your relationship.',
              Icons.chat,
              Colors.amber,
            ),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              context,
              'Great Job on Environment!',
              'Your living environment is excellent. Keep maintaining these standards.',
              Icons.celebration,
              Colors.green,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Detailed report saved!')),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Download Full Report'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
