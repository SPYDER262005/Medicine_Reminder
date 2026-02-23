import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../core/app_colors.dart';
import '../providers/medicine_provider.dart';
import '../core/time_helper.dart';
import '../models/medicine_model.dart';
import 'doctors_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();
    final medicines = provider.medicines;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: const Text(
              'Schedule',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.medical_services_outlined,
                  color: AppColors.primary,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DoctorsScreen()),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 100), // Space for title
                ],
              ),
            ),
          ),

          // Horizontal Calendar Section
          SliverToBoxAdapter(child: _buildHorizontalCalendar()),

          ..._buildTimeGroupedList(medicines),
        ],
      ),
    );
  }

  List<Widget> _buildTimeGroupedList(List<Medicine> medicines) {
    if (medicines.isEmpty) {
      return [
        const SliverFillRemaining(
          child: Center(child: Text('No doses scheduled for today.')),
        ),
      ];
    }
    final Map<String, List<Medicine>> grouped = {
      'Morning': [],
      'Afternoon': [],
      'Evening': [],
      'Night': [],
    };
    for (var m in medicines) {
      final hour = m.time.hour;
      if (hour >= 5 && hour < 12)
        grouped['Morning']!.add(m);
      else if (hour >= 12 && hour < 17)
        grouped['Afternoon']!.add(m);
      else if (hour >= 17 && hour < 21)
        grouped['Evening']!.add(m);
      else
        grouped['Night']!.add(m);
    }
    List<Widget> slivers = [];
    grouped.forEach((label, meds) {
      if (meds.isNotEmpty) {
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) => _buildScheduleItem(meds[i]),
                childCount: meds.length,
              ),
            ),
          ),
        );
      }
    });
    return slivers;
  }

  Widget _buildHorizontalCalendar() {
    final now = DateTime.now();
    return Column(
      children: [
        // Month Selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () => setState(
                      () => selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month - 1,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: () => setState(
                      () => selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month + 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Days Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map(
                  (d) => Text(
                    d,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        // Calendar Grid
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            itemCount:
                DateTime(selectedDate.year, selectedDate.month + 1, 0).day +
                DateTime(selectedDate.year, selectedDate.month, 1).weekday % 7,
            itemBuilder: (context, index) {
              final firstDayOffset =
                  DateTime(selectedDate.year, selectedDate.month, 1).weekday %
                  7;
              if (index < firstDayOffset) return const SizedBox.shrink();

              final day = index - firstDayOffset + 1;
              final date = DateTime(selectedDate.year, selectedDate.month, day);
              final isSelected =
                  date.day == selectedDate.day &&
                  date.month == selectedDate.month &&
                  date.year == selectedDate.year;
              final isToday =
                  date.day == now.day &&
                  date.month == now.month &&
                  date.year == now.year;

              return GestureDetector(
                onTap: () => setState(() => selectedDate = date),
                child: AnimatedContainer(
                  duration: 300.ms,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : (isToday
                              ? AppColors.primary.withOpacity(0.05)
                              : AppColors.surface),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.05),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: isSelected || isToday
                              ? FontWeight.w900
                              : FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (isToday && !isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(medicine) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(medicine.colorCode).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.access_time_filled_rounded,
                color: Color(medicine.colorCode),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    'Dose: ${medicine.dose}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Time: ${TimeHelper.format12Hour(medicine.time)}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            _buildStatusChip(context, medicine),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05);
  }

  Widget _buildStatusChip(BuildContext context, Medicine medicine) {
    final provider = context.watch<MedicineProvider>();
    final isTaken = provider.isDoseTaken(medicine.id, medicine.time);
    final isMissed =
        !isTaken &&
        (DateTime.now().isAfter(medicine.time.add(const Duration(hours: 1))));

    return GestureDetector(
      onTap: () => provider.toggleDose(medicine.id, medicine.time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isTaken
              ? Colors.green.withOpacity(0.12)
              : (isMissed
                    ? Colors.red.withOpacity(0.12)
                    : AppColors.primary.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isTaken
                ? Colors.green
                : (isMissed ? Colors.red : AppColors.primary),
            width: 1,
          ),
        ),
        child: Text(
          isTaken ? 'EAT' : (isMissed ? 'MISS' : 'PENDING'),
          style: TextStyle(
            color: isTaken
                ? Colors.green
                : (isMissed ? Colors.red : AppColors.primary),
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
