import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine_model.dart';
import '../core/app_colors.dart';

import '../widgets/medicine_type_selector.dart';

class AddMedicineScreen extends StatefulWidget {
  final Medicine? medicine;

  const AddMedicineScreen({Key? key, this.medicine}) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController doseController;
  late TextEditingController notesController;
  late TextEditingController stockController;
  late TextEditingController thresholdController;
  late TextEditingController purposeController;
  late TextEditingController doctorNameController;
  late TextEditingController sideEffectsController;
  late TextEditingController warningsController;
  late TextEditingController allergiesController;
  late TextEditingController ageGroupController;
  late TextEditingController applyAreaController;

  List<DateTime> reminderTimes = [];
  DateTime? selectedExpiryDate;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  String selectedType = 'Pill';
  int selectedColorIndex = 0;
  bool isDaily = true;
  bool beforeFood = false;
  List<int> customDays = [];
  bool enableReminder = false;
  int doseAmount = 1;
  String? mealInstruction;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.medicine?.name ?? '');
    doseController = TextEditingController(text: widget.medicine?.dose ?? '');
    notesController = TextEditingController(text: widget.medicine?.notes ?? '');
    stockController = TextEditingController(
      text: widget.medicine?.stock.toString() ?? '',
    );
    thresholdController = TextEditingController(
      text: widget.medicine?.lowStockThreshold.toString() ?? '5',
    );
    purposeController = TextEditingController(
      text: widget.medicine?.purpose ?? '',
    );
    doctorNameController = TextEditingController(
      text: widget.medicine?.doctorName ?? '',
    );
    sideEffectsController = TextEditingController(
      text: widget.medicine?.sideEffects ?? '',
    );
    warningsController = TextEditingController(
      text: widget.medicine?.warnings ?? '',
    );
    allergiesController = TextEditingController(
      text: widget.medicine?.allergies ?? '',
    );
    ageGroupController = TextEditingController(
      text: widget.medicine?.ageGroup ?? '',
    );
    applyAreaController = TextEditingController(
      text: widget.medicine?.applyArea ?? '',
    );

    reminderTimes = widget.medicine?.reminderTimes ?? [];
    enableReminder = reminderTimes.isNotEmpty;
    selectedExpiryDate = widget.medicine?.expiryDate;
    selectedType = widget.medicine?.type ?? 'Pill';
    isDaily = widget.medicine?.isDaily ?? true;
    beforeFood = widget.medicine?.beforeFood ?? false;
    customDays = widget.medicine?.customDays ?? [];
    startDate = widget.medicine?.startDate ?? DateTime.now();
    endDate =
        widget.medicine?.endDate ?? DateTime.now().add(const Duration(days: 7));
    mealInstruction = widget.medicine?.mealInstruction;

    if (widget.medicine != null) {
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
    stockController.dispose();
    thresholdController.dispose();
    purposeController.dispose();
    doctorNameController.dispose();
    sideEffectsController.dispose();
    warningsController.dispose();
    allergiesController.dispose();
    ageGroupController.dispose();
    applyAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditMode = widget.medicine != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Medicine details' : 'Add Reminder',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          children: [
            _buildLabel('Medicine name'),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Write here',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              validator: (v) => v!.isEmpty ? 'Name is required' : null,
            ),

            const SizedBox(height: 16),

            _buildLabel('Purpose / Used for'),
            TextFormField(
              controller: purposeController,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: 'What is this medicine for?',
                prefixIcon: Icon(Icons.info_outline_rounded),
                fillColor: AppColors.surface,
              ),
              validator: (v) => v!.isEmpty ? 'Purpose is required' : null,
            ).animate().fadeIn(delay: 50.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            _buildLabel('Medication Type'),
            MedicineTypeSelector(
              selectedType: selectedType,
              onTypeSelected: (type) => setState(() => selectedType = type),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            _buildLabel('Dosage'),
            TextFormField(
              controller: doseController,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: 'e.g. 1 Pill, 5ml',
                prefixIcon: Icon(Icons.scale_rounded),
                fillColor: AppColors.surface,
              ),
              validator: (v) => v!.isEmpty ? 'Dose is required' : null,
            ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            // Reminder Toggle - Matching Theme
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceMint,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Enable Reminder',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: const Text('Get notified when to take'),
                value: enableReminder,
                onChanged: (val) => setState(() => enableReminder = val),
                secondary: Icon(
                  enableReminder
                      ? Icons.notifications_active_rounded
                      : Icons.notifications_off_rounded,
                  color: AppColors.primary,
                ),
              ),
            ),

            _buildLabel('Start & Finish'),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365 * 5),
                        ),
                      );
                      if (date != null) setState(() => startDate = date);
                    },
                    child: _buildDatePickerBox(
                      DateFormat('d MMMM, yyyy').format(startDate),
                      Icons.calendar_today_rounded,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: startDate,
                        lastDate: DateTime.now().add(
                          const Duration(days: 365 * 10),
                        ),
                      );
                      if (date != null) setState(() => endDate = date);
                    },
                    child: _buildDatePickerBox(
                      DateFormat('d MMMM, yyyy').format(endDate),
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLabel('When to take'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: mealInstruction != null
                      ? _buildMiniChip(mealInstruction!)
                      : const Text('Select timing'),
                  items:
                      [
                            'Before Breakfast',
                            'After Breakfast',
                            'Before Lunch',
                            'After Lunch',
                            'Before Dinner',
                            'After Dinner',
                          ]
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                  onChanged: (v) {
                    setState(() {
                      mealInstruction = v;
                      // Auto-set time based on instruction
                      if (v != null) {
                        DateTime? autoTime;
                        final now = DateTime.now();
                        switch (v) {
                          case 'Before Breakfast':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              7,
                              0,
                            );
                            break;
                          case 'After Breakfast':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              8,
                              30,
                            );
                            break;
                          case 'Before Lunch':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              12,
                              30,
                            );
                            break;
                          case 'After Lunch':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              13,
                              30,
                            );
                            break;
                          case 'Before Dinner':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              19,
                              30,
                            );
                            break;
                          case 'After Dinner':
                            autoTime = DateTime(
                              now.year,
                              now.month,
                              now.day,
                              21,
                              0,
                            );
                            break;
                        }
                        if (autoTime != null &&
                            !reminderTimes.any(
                              (t) =>
                                  t.hour == autoTime!.hour &&
                                  t.minute == autoTime.minute,
                            )) {
                          reminderTimes.add(autoTime);
                          reminderTimes.sort((a, b) => a.compareTo(b));
                        }
                      }
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            _buildLabel('Reminder Times'),
            if (reminderTimes.isEmpty)
              const Text(
                'No times set. Tap + to add',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            else
              Wrap(
                spacing: 8,
                children: reminderTimes
                    .map(
                      (time) => Chip(
                        label: Text(DateFormat('h:mm a').format(time)),
                        onDeleted: () =>
                            setState(() => reminderTimes.remove(time)),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                    .toList(),
              ),
            TextButton.icon(
              onPressed: _selectTime,
              icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
              label: const Text('Add Time'),
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Amount'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () => setState(
                                () => doseAmount = doseAmount > 1
                                    ? doseAmount - 1
                                    : 1,
                              ),
                            ),
                            Text(
                              doseAmount < 10
                                  ? '0$doseAmount'
                                  : doseAmount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              onPressed: () => setState(() => doseAmount++),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Frequency'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Daily',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (!isDaily) ...[const SizedBox(height: 12), _buildDaySelector()],

            const SizedBox(height: 16),

            _buildLabel('Theme Color'),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: AppColors.medicineColors.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final color = AppColors.medicineColors[index];
                  final isSelected = selectedColorIndex == index;
                  return InkWell(
                    onTap: () => setState(() => selectedColorIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.textPrimary
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded, color: Colors.white)
                          : null,
                    ),
                  ).animate().fadeIn(delay: (400 + (index * 50)).ms).scale();
                },
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Current Stock'),
                      TextFormField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g. 30',
                          prefixIcon: Icon(Icons.inventory_2_rounded),
                          fillColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Low Stock Alert'),
                      TextFormField(
                        controller: thresholdController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g. 5',
                          prefixIcon: Icon(
                            Icons.notification_important_rounded,
                          ),
                          fillColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            _buildLabel('Expiry Date'),
            InkWell(
              onTap: _selectExpiryDate,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.event_note_rounded,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      selectedExpiryDate == null
                          ? 'Choose Expiry Date'
                          : "${selectedExpiryDate!.day}/${selectedExpiryDate!.month}/${selectedExpiryDate!.year}",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),

            _buildSectionHeader('Medicine Info'),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Doctor Name'),
                      TextFormField(
                        controller: doctorNameController,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Dr. Smith',
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          fillColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Age Group'),
                      TextFormField(
                        controller: ageGroupController,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'e.g. Adults',
                          prefixIcon: Icon(Icons.groups_rounded),
                          fillColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (selectedType == 'Syrup' || selectedType == 'Cream') ...[
              _buildLabel(
                selectedType == 'Syrup' ? 'Instructions' : 'Apply Area',
              ),
              TextFormField(
                controller: selectedType == 'Syrup'
                    ? notesController
                    : applyAreaController,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: selectedType == 'Syrup'
                      ? 'Shake well'
                      : 'e.g. Left arm',
                  prefixIcon: Icon(
                    selectedType == 'Syrup'
                        ? Icons.note_alt_rounded
                        : Icons.location_on_rounded,
                  ),
                  fillColor: AppColors.surface,
                ),
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                const Icon(
                  Icons.restaurant_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Take before food?',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: beforeFood,
                  onChanged: (v) => setState(() => beforeFood = v),
                  activeColor: AppColors.primary,
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSectionHeader('Safety Section'),

            _buildLabel('Side Effects'),
            TextFormField(
              controller: sideEffectsController,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter potential side effects',
                prefixIcon: Icon(Icons.warning_amber_rounded),
                fillColor: AppColors.surface,
              ),
            ),

            const SizedBox(height: 16),

            _buildLabel('Warnings & Allergies'),
            TextFormField(
              controller: warningsController,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: 'e.g. Allergy to penicillin',
                prefixIcon: Icon(Icons.new_releases_rounded),
                fillColor: AppColors.surface,
              ),
            ),

            const SizedBox(height: 40),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveMedicine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C2A0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  isEditMode ? 'Update' : 'Create',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 500.ms).scale(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: AppColors.primary,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  Widget _buildFrequencyChip(
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.05),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(7, (index) {
        final dayNum = index + 1;
        final isSelected = customDays.contains(dayNum);
        return InkWell(
          onTap: () {
            setState(() {
              if (isSelected)
                customDays.remove(dayNum);
              else
                customDays.add(dayNum);
            });
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.secondary : AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.secondary
                    : AppColors.primary.withOpacity(0.05),
              ),
            ),
            child: Text(
              days[index],
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
        );
      }),
    );
  }

  void _saveMedicine() {
    if (!_formKey.currentState!.validate()) return;
    final medicine = Medicine(
      id: widget.medicine?.id,
      name: nameController.text.trim(),
      dose: doseController.text.trim(),
      time: enableReminder && reminderTimes.isNotEmpty
          ? reminderTimes.first
          : DateTime.now(),
      reminderTimes: enableReminder ? reminderTimes : [],
      isDaily: isDaily,
      customDays: customDays,
      type: selectedType,
      notes: notesController.text.trim(),
      colorCode: AppColors.medicineColors[selectedColorIndex].value,
      stock: int.tryParse(stockController.text.trim()) ?? 0,
      lowStockThreshold: int.tryParse(thresholdController.text.trim()) ?? 5,
      expiryDate: selectedExpiryDate,
      purpose: purposeController.text.trim(),
      doctorName: doctorNameController.text.trim(),
      beforeFood: beforeFood,
      sideEffects: sideEffectsController.text.trim(),
      warnings: warningsController.text.trim(),
      allergies: allergiesController.text.trim(),
      ageGroup: ageGroupController.text.trim(),
      applyArea: applyAreaController.text.trim(),
      startDate: startDate,
      endDate: endDate,
      mealInstruction: mealInstruction,
    );
    final provider = context.read<MedicineProvider>();
    if (widget.medicine != null) {
      provider.updateMedicine(widget.medicine!.id, medicine);
    } else {
      provider.addMedicine(medicine);
    }
    Navigator.pop(context);
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      setState(() {
        if (!reminderTimes.any(
          (t) => t.hour == time.hour && t.minute == time.minute,
        )) {
          reminderTimes.add(dateTime);
          reminderTimes.sort((a, b) => a.compareTo(b));
        }
      });
    }
  }

  void _selectExpiryDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate:
          selectedExpiryDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (date != null) setState(() => selectedExpiryDate = date);
  }

  Widget _buildDatePickerBox(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
          ),
          Icon(icon, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  Widget _buildMiniChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.close, size: 12, color: Colors.grey),
        ],
      ),
    );
  }
}
