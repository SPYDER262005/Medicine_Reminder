import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine_model.dart';
import '../core/app_colors.dart';
import '../core/time_helper.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/medicine_type_selector.dart';

class AddMedicineScreen extends StatefulWidget {
  final Medicine? medicine; // null = add mode, not null = edit mode

  const AddMedicineScreen({Key? key, this.medicine}) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final notesController = TextEditingController();
  
  DateTime? selectedTime;
  String selectedType = 'Tablet';
  int selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    
    // If editing, pre-fill the form
    if (widget.medicine != null) {
      nameController.text = widget.medicine!.name;
      doseController.text = widget.medicine!.dose;
      notesController.text = widget.medicine!.notes ?? '';
      selectedTime = widget.medicine!.time;
      selectedType = widget.medicine!.type;
      
      // Find matching color index
      selectedColorIndex = AppColors.medicineColors.indexWhere(
        (color) => color.value == widget.medicine!.colorCode,
      );
      if (selectedColorIndex == -1) selectedColorIndex = 0;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    doseController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.medicine != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Medicine' : 'Add Medicine'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main Info Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medicine Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: nameController,
                        label: 'Medicine Name',
                        icon: Icons.medication,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter medicine name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: doseController,
                        label: 'Dose (e.g., 1 tablet, 5ml)',
                        icon: Icons.local_pharmacy,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter dose';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: notesController,
                        label: 'Notes (Optional)',
                        icon: Icons.note,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Medicine Type Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: MedicineTypeSelector(
                    selectedType: selectedType,
                    onTypeSelected: (type) {
                      setState(() {
                        selectedType = type;
                      });
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Time Selection Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reminder Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        icon: const Icon(Icons.access_time),
                        label: Text(
                          selectedTime == null
                              ? 'Select Time'
                              : TimeHelper.format12Hour(selectedTime!),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime != null
                                ? TimeOfDay.fromDateTime(selectedTime!)
                                : TimeOfDay.now(),
                          );
                          if (time != null) {
                            final now = DateTime.now();
                            setState(() {
                              selectedTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                time.hour,
                                time.minute,
                              );
                              // If time is in the past, schedule for tomorrow
                              if (selectedTime!.isBefore(now)) {
                                selectedTime = selectedTime!.add(
                                  const Duration(days: 1),
                                );
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Color Selection Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          AppColors.medicineColors.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.medicineColors[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? AppColors.textPrimary
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: selectedColorIndex == index
                                    ? [
                                        BoxShadow(
                                          color: AppColors.medicineColors[index]
                                              .withOpacity(0.5),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: selectedColorIndex == index
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                  elevation: 4,
                ),
                onPressed: _saveMedicine,
                child: Text(
                  isEditMode ? 'Update Medicine' : 'Save Medicine',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMedicine() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reminder time'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final medicine = Medicine(
      id: widget.medicine?.id, // Preserve ID when editing
      name: nameController.text.trim(),
      dose: doseController.text.trim(),
      time: selectedTime!,
      type: selectedType,
      notes: notesController.text.trim().isEmpty
          ? null
          : notesController.text.trim(),
      colorCode: AppColors.medicineColors[selectedColorIndex].value,
    );

    final provider = context.read<MedicineProvider>();
    
    if (widget.medicine != null) {
      // Edit mode
      provider.updateMedicine(widget.medicine!.id, medicine);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${medicine.name} updated successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      // Add mode
      provider.addMedicine(medicine);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${medicine.name} added successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    }

    Navigator.pop(context);
  }
}
