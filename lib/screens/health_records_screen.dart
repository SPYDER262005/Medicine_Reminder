import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../providers/health_record_provider.dart';
import '../models/health_record_model.dart';

class HealthRecordsScreen extends StatelessWidget {
  const HealthRecordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Insights'),
      ),
      body: Consumer<HealthRecordProvider>(
        builder: (context, provider, child) {
          if (provider.records.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 80, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text('No records tracked yet', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: provider.records.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final record = provider.records[index];
              return Dismissible(
                key: Key(record.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                ),
                onDismissed: (_) {
                  provider.deleteRecord(record.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color(record.colorCode).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Icon(
                            _getCategoryIcon(record.iconCode),
                            color: Color(record.colorCode),
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              record.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${record.date.day}/${record.date.month}/${record.date.year}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        record.value,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: Duration(milliseconds: 100 * (index + 1))).slideX(begin: 0.05);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddRecordDialog(context),
        icon: const Icon(Icons.add_chart_rounded),
        label: const Text('Add Record'),
      ).animate().scale(delay: 400.ms),
    );
  }

  void _showAddRecordDialog(BuildContext context) {
    final titleController = TextEditingController();
    final valueController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    
    // Icon and Color selection (Simplified for the dialog)
    int selectedIconCode = Icons.favorite_rounded.codePoint;
    int selectedColorValue = Colors.red.value;

    final List<Map<String, dynamic>> categories = [
      {'name': 'Blood Pressure', 'icon': Icons.favorite_rounded, 'color': Colors.red},
      {'name': 'Glucose', 'icon': Icons.bloodtype_rounded, 'color': Colors.redAccent},
      {'name': 'Weight', 'icon': Icons.monitor_weight_rounded, 'color': Colors.blue},
      {'name': 'Heart Rate', 'icon': Icons.shutter_speed_rounded, 'color': Colors.orange},
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Health Record'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Map<String, dynamic>>(
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Row(
                          children: [
                            Icon(cat['icon'], color: cat['color'], size: 20),
                            const SizedBox(width: 8),
                            Text(cat['name']),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          titleController.text = val['name'];
                          selectedIconCode = (val['icon'] as IconData).codePoint;
                          selectedColorValue = (val['color'] as Color).value;
                        });
                      }
                    },
                    validator: (v) => v == null ? 'Please select category' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: valueController,
                    decoration: const InputDecoration(labelText: 'Value (e.g. 120/80, 95 mg/dL)', prefixIcon: Icon(Icons.edit_note_rounded)),
                    validator: (v) => v!.isEmpty ? 'Value is required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final record = HealthRecord(
                    title: titleController.text.trim(),
                    value: valueController.text.trim(),
                    date: DateTime.now(),
                    iconCode: selectedIconCode,
                    colorCode: selectedColorValue,
                  );
                  context.read<HealthRecordProvider>().addRecord(record);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(int codePoint) {
    if (codePoint == Icons.favorite_rounded.codePoint) return Icons.favorite_rounded;
    if (codePoint == Icons.bloodtype_rounded.codePoint) return Icons.bloodtype_rounded;
    if (codePoint == Icons.monitor_weight_rounded.codePoint) return Icons.monitor_weight_rounded;
    if (codePoint == Icons.shutter_speed_rounded.codePoint) return Icons.shutter_speed_rounded;
    return Icons.analytics_rounded;
  }
}
