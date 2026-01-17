import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import '../widgets/medicine_tile.dart';
import '../widgets/empty_state_widget.dart';
import '../core/app_colors.dart';
import '../core/time_helper.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();
    final medicines = provider.medicines;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '💊',
                              style: TextStyle(fontSize: 32),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Medicine Reminder',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (medicines.isNotEmpty) _buildStatsRow(medicines),
                      ],
                    ),
                  ),
                ),
              ),
              title: const Text(
                'Medicine Reminder',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Content
          medicines.isEmpty
              ? const SliverFillRemaining(
                  child: EmptyStateWidget(),
                )
              : SliverPadding(
                  padding: const EdgeInsets.only(top: 16, bottom: 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildTimeSection(
                          context,
                          medicines,
                          ['Morning', 'Afternoon', 'Evening', 'Night'][index],
                        );
                      },
                      childCount: 4,
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddMedicineScreen()),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Medicine',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(List medicines) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '📋',
              medicines.length.toString(),
              'Total',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withOpacity(0.5),
          ),
          Expanded(
            child: _buildStatItem(
              '⏰',
              _getNextMedicineTime(medicines),
              'Next',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  String _getNextMedicineTime(List medicines) {
    if (medicines.isEmpty) return '--';
    
    final now = DateTime.now();
    final upcoming = medicines.where((m) => m.time.isAfter(now)).toList();
    
    if (upcoming.isEmpty) {
      return TimeHelper.format12Hour(medicines.first.time);
    }
    
    return TimeHelper.format12Hour(upcoming.first.time);
  }

  Widget _buildTimeSection(BuildContext context, List medicines, String period) {
    final filteredMedicines = medicines.where((medicine) {
      return TimeHelper.getTimeOfDayPeriod(medicine.time) == period;
    }).toList();

    if (filteredMedicines.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                TimeHelper.getTimeOfDayIcon(period),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    period,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    TimeHelper.getTimeRangeText(period),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryExtraLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${filteredMedicines.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...filteredMedicines.map((medicine) => MedicineTile(medicine: medicine)),
        const SizedBox(height: 8),
      ],
    );
  }
}
