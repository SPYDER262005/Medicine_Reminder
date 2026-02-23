import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class MedicineTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const MedicineTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> types = [
      {'name': 'Pill', 'icon': Icons.medication_rounded},
      {'name': 'Syrup', 'icon': Icons.water_drop_rounded},
      {'name': 'Injection', 'icon': Icons.vaccines_rounded},
      {'name': 'Cream', 'icon': Icons.format_color_fill_rounded},
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: types.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = type['name'] == selectedType;

          return GestureDetector(
            onTap: () => onTypeSelected(type['name']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 80,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.05),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    type['icon'],
                    color: isSelected ? Colors.white : AppColors.primary,
                    size: 30,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    type['name'],
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
