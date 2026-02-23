import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/medicine_provider.dart';
import '../core/app_colors.dart';
import '../widgets/medicine_tile.dart';
import '../widgets/empty_state_widget.dart';
import 'add_medicine_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;

  const CategoryScreen({Key? key, required this.categoryName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();

    final medicines = provider.medicines.where((m) {
      if (categoryName == 'Pills') {
        return m.type.toLowerCase() == 'pill' ||
            m.type.toLowerCase() == 'tablet' ||
            m.type.toLowerCase() == 'capsule';
      }
      return m.type.toLowerCase() == categoryName.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('$categoryName Inventory'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: medicines.isEmpty
          ? const EmptyStateWidget(isSearch: false)
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MedicineTile(medicine: medicines[index]),
                ).animate().fadeIn().slideX(begin: 0.1);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddMedicineScreen()),
        ),
        label: Text(
          'Add $categoryName',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
