import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';

class HealthGuideScreen extends StatelessWidget {
  const HealthGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> healthTips = [
      {
        'problem': 'Fever & Headache',
        'icon': Icons.thermostat_rounded,
        'medicines': [
          {'name': 'Paracetamol', 'type': 'Pill / Syrup'},
          {'name': 'Ibuprofen', 'type': 'Pill'},
        ],
        'color': Colors.orange,
      },
      {
        'problem': 'Cold & Cough',
        'icon': Icons.air_rounded,
        'medicines': [
          {'name': 'Cough Syrup', 'type': 'Syrup'},
          {'name': 'Cetirizine', 'type': 'Pill'},
        ],
        'color': Colors.blue,
      },
      {
        'problem': 'Loose Motion',
        'icon': Icons.water_drop_rounded,
        'medicines': [
          {'name': 'ORS Liquid', 'type': 'Syrup'},
          {'name': 'Zinc Tablet', 'type': 'Pill'},
        ],
        'color': Colors.lightGreen,
      },
      {
        'problem': 'Injury & Bleeding',
        'icon': Icons.healing_rounded,
        'medicines': [
          {'name': 'Betadine', 'type': 'Liquid / Cream'},
          {'name': 'Antibiotic Ointment', 'type': 'Cream'},
          {'name': 'Bandage', 'type': 'First Aid'},
        ],
        'color': Colors.red,
      },
      {
        'problem': 'Acidity & Gas',
        'icon': Icons.local_fire_department_rounded,
        'medicines': [
          {'name': 'Pantoprazole', 'type': 'Pill'},
          {'name': 'Antacid', 'type': 'Syrup'},
        ],
        'color': Colors.teal,
      },
      {
        'problem': 'Weakness',
        'icon': Icons.bolt_rounded,
        'medicines': [
          {'name': 'Multivitamin', 'type': 'Pill'},
          {'name': 'Vitamin Syrup', 'type': 'Syrup'},
        ],
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Health Guide')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Common Problems & Solutions',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Quick guide to find the right medicine for simple health issues.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ...healthTips.map((tip) => _buildProblemCard(tip)).toList(),
          const SizedBox(height: 24),
          _buildWarningBox(),
        ],
      ),
    );
  }

  Widget _buildProblemCard(Map<String, dynamic> tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: (tip['color'] as Color).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(tip['icon'], color: tip['color'], size: 28),
              const SizedBox(width: 12),
              Text(
                tip['problem'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          ...(tip['medicines'] as List)
              .map(
                (med) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        med['name'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        med['type'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildWarningBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.error.withOpacity(0.2)),
      ),
      child: Row(
        children: const [
          Icon(Icons.warning_amber_rounded, color: AppColors.error),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Warning: Injection and serious medications should only be used with doctor advice.',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
