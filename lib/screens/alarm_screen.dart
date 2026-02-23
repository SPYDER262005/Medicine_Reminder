import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../models/medicine_model.dart';
import '../core/time_helper.dart';
import '../core/notification_service.dart';

class AlarmScreen extends StatelessWidget {
  final Medicine medicine;

  const AlarmScreen({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(medicine.colorCode).withOpacity(0.8),
              AppColors.backgroundDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Pulsing Icon
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_rounded,
                  size: 100,
                  color: Colors.white,
                ),
              ).animate(onPlay: (c) => c.repeat())
               .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 1.seconds, curve: Curves.easeInOut)
               .fadeIn(duration: 1.seconds),

              const SizedBox(height: 40),

              Text(
                'Reminder',
                style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ).animate().fadeIn(delay: 400.ms),

              Text(
                medicine.name,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),

              const SizedBox(height: 16),

              Text(
                '${medicine.dose} • ${medicine.type}',
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.white70),
              ).animate().fadeIn(delay: 800.ms),

              const SizedBox(height: 8),

              Text(
                'Scheduled for ${TimeHelper.format12Hour(medicine.time)}',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white60),
              ).animate().fadeIn(delay: 1000.ms),

              const Spacer(),

              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(medicine.colorCode),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: const Text('I TOOK IT', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSnoozeButton(context, 5),
                        _buildSnoozeButton(context, 10),
                        _buildSnoozeButton(context, 15),
                      ],
                    ).animate().fadeIn(delay: 1300.ms),
                    
                    const SizedBox(height: 20),
                    
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Dismiss',
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                    ).animate().fadeIn(delay: 1400.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSnoozeButton(BuildContext context, int minutes) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            NotificationService.snooze(
              medicine.id.hashCode + 999, // Offset for snooze notifications
              'Medicine Reminder',
              'Snoozed: ${medicine.name} (${medicine.dose})',
              minutes,
            );
            Navigator.pop(context);
          },
          icon: const Icon(Icons.snooze_rounded, color: Colors.white),
        ),
        Text(
          '${minutes}m',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
