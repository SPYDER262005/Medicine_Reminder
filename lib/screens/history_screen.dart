import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../providers/medicine_provider.dart';
import '../core/time_helper.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();
    final logs = provider.doseLogs.reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Activity History'),
            centerTitle: true,
            backgroundColor: AppColors.background,
          ),
          if (logs.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('No medication history yet.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final log = logs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  (log.isTaken
                                          ? AppColors.success
                                          : AppColors.error)
                                      .withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              log.isTaken
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              color: log.isTaken
                                  ? AppColors.success
                                  : AppColors.error,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  log.medicineName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  '${log.isTaken ? 'Taken' : 'Missed'} at ${TimeHelper.format12Hour(log.scheduledTime)}',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn().slideX(begin: 0.1);
                }, childCount: logs.length),
              ),
            ),
        ],
      ),
    );
  }
}
