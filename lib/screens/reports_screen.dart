import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine_model.dart';
import '../models/dose_log_model.dart';
import '../core/time_helper.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final medicineProvider = context.watch<MedicineProvider>();
    final List<DoseLog> logs = List<DoseLog>.from(medicineProvider.doseLogs)
      ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));
    final List<Medicine> medicines = medicineProvider.medicines;

    // Summary logic (last 7 days)
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final weekLogs = logs
        .where((l) => l.scheduledTime.isAfter(weekAgo))
        .toList();

    final takenCount = weekLogs.where((l) => l.isTaken).length;
    final totalCount = weekLogs.length;
    final missedCount = totalCount - takenCount;
    final score = totalCount == 0 ? 0 : (takenCount / totalCount * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Timeline'),
        actions: [
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Weekly Summary Card
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryItem(
                          'Score',
                          '$score%',
                          Icons.grade_rounded,
                        ),
                        _buildSummaryItem(
                          'Taken',
                          '$takenCount',
                          Icons.check_circle_rounded,
                        ),
                        _buildSummaryItem(
                          'Missed',
                          '$missedCount',
                          Icons.cancel_rounded,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white24, thickness: 1),
                    const SizedBox(height: 16),
                    Text(
                      score >= 80
                          ? 'Your adherence is excellent this week!'
                          : score >= 50
                          ? 'You are doing well, keep it up!'
                          : 'Try to stay more consistent with your doses.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn().scale(duration: 400.ms),
          ),

          // Timeline Header
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Text('Recent History', style: theme.textTheme.titleLarge),
            ),
          ),

          // Timeline List
          logs.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No activity data available yet.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final log = logs[index];
                      final medicine =
                          medicines.any((m) => m.id == log.medicineId)
                          ? medicines.firstWhere((m) => m.id == log.medicineId)
                          : null;
                      final isLast = index == logs.length - 1;
                      return _buildTimelineItem(context, log, medicine, isLast);
                    }, childCount: logs.length),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 12),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    dynamic log,
    dynamic medicine,
    bool isLast,
  ) {
    final theme = Theme.of(context);
    final color = medicine != null
        ? Color(medicine.colorCode)
        : AppColors.primary;
    final isTaken = log.isTaken;

    return IntrinsicHeight(
      child: Row(
        children: [
          // Left Line and Dot
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isTaken ? AppColors.success : color.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isTaken ? Colors.white : color,
                    width: 2,
                  ),
                ),
                child: isTaken
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            log.medicineName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Scheduled: ${TimeHelper.format12Hour(log.scheduledTime)}',
                            style: theme.textTheme.bodySmall,
                          ),
                          if (log.actualTime != null)
                            Text(
                              'Taken: ${TimeHelper.format12Hour(log.actualTime!)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (isTaken ? AppColors.success : AppColors.warning)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isTaken ? 'Taken' : 'Missed',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isTaken
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideX(begin: 0.1);
  }
}
