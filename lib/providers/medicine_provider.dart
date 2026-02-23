import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../models/dose_log_model.dart';

class MedicineProvider extends ChangeNotifier {
  List<Medicine> medicines = [];
  List<DoseLog> doseLogs = [];
  final box = Hive.box<Medicine>('medicines');
  final logsBox = Hive.box<DoseLog>('dose_logs');

  MedicineProvider() {
    loadMedicines();
  }

  void loadMedicines() {
    medicines = box.values.toList();
    if (medicines.isEmpty) {
      _seedData();
      medicines = box.values.toList();
    }
    doseLogs = logsBox.values.toList();
    _sortMedicines();
    notifyListeners();
  }

  void _seedData() {
    final now = DateTime.now();
    final expiry = now.add(const Duration(days: 365));

    // Helper to create date with specific hour
    DateTime timeAt(int hour, int minute) {
      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    final initialMedicines = [
      // Morning
      Medicine(
        name: 'Pantoprazole',
        dose: '40 mg',
        time: timeAt(7, 0),
        type: 'Pill',
        stock: 30,
        purpose: 'Acidity',
        expiryDate: expiry,
        beforeFood: true,
        mealInstruction: 'Before Breakfast',
        colorCode: 0xFF00C2A0,
      ),
      Medicine(
        name: 'Multivitamin',
        dose: '1 Tablet',
        time: timeAt(8, 30),
        type: 'Vitamins',
        stock: 60,
        purpose: 'General Health',
        expiryDate: expiry,
        mealInstruction: 'After Breakfast',
        colorCode: 0xFFFFB300,
      ),
      // Afternoon
      Medicine(
        name: 'Paracetamol',
        dose: '500 mg',
        time: timeAt(13, 0),
        type: 'Pill',
        stock: 20,
        purpose: 'Pain Relief',
        expiryDate: expiry,
        mealInstruction: 'After Lunch',
        colorCode: 0xFFFF5252,
      ),
      // Evening
      Medicine(
        name: 'Cough Syrup',
        dose: '10 ml',
        time: timeAt(18, 0),
        type: 'Syrup',
        stock: 2,
        purpose: 'Dry Cough',
        expiryDate: expiry,
        colorCode: 0xFF2196F3,
      ),
      // Night
      Medicine(
        name: 'Cetirizine',
        dose: '10 mg',
        time: timeAt(22, 0),
        type: 'Pill',
        stock: 15,
        purpose: 'Allergy Relief',
        expiryDate: expiry,
        colorCode: 0xFF9C27B0,
      ),
      Medicine(
        name: 'Calpol Syrup',
        dose: '5 ml',
        time: timeAt(15, 0),
        type: 'Syrup',
        stock: 2,
        purpose: 'Fever (Children)',
        expiryDate: expiry,
        colorCode: 0xFFFF7043,
      ),
      Medicine(
        name: 'Digene',
        dose: '10 ml',
        time: timeAt(13, 30),
        type: 'Syrup',
        stock: 1,
        purpose: 'Acidity',
        expiryDate: expiry,
        colorCode: 0xFF8D6E63,
      ),
      Medicine(
        name: 'Multivitamin Syrup',
        dose: '15 ml',
        time: timeAt(9, 0),
        type: 'Syrup',
        stock: 2,
        purpose: 'Nutrition',
        expiryDate: expiry,
        colorCode: 0xFFFFB74D,
      ),

      // INJECTIONS
      Medicine(
        name: 'Insulin',
        dose: '10 Units',
        time: timeAt(7, 30),
        type: 'Injection',
        stock: 10,
        purpose: 'Diabetes',
        expiryDate: expiry,
        beforeFood: true,
        colorCode: 0xFF42A5F5,
      ),
      Medicine(
        name: 'Vitamin B12 Injection',
        dose: '1 ml',
        time: timeAt(10, 0),
        type: 'Injection',
        stock: 5,
        purpose: 'Energy Boost',
        expiryDate: expiry,
        colorCode: 0xFF5C6BC0,
      ),

      // CREAMS / OINTMENTS
      Medicine(
        name: 'Betnovate Cream',
        dose: 'Apply',
        time: timeAt(22, 0),
        type: 'Cream',
        stock: 2,
        purpose: 'Skin Inflammation',
        expiryDate: expiry,
        colorCode: 0xFF66BB6A,
      ),
      Medicine(
        name: 'Soframycin',
        dose: 'Apply',
        time: timeAt(11, 0),
        type: 'Cream',
        stock: 3,
        purpose: 'Wound Care',
        expiryDate: expiry,
        colorCode: 0xFF26A69A,
      ),
      Medicine(
        name: 'Volini Gel',
        dose: 'Apply',
        time: timeAt(20, 30),
        type: 'Cream',
        stock: 1,
        purpose: 'Pain Relief',
        expiryDate: expiry,
        colorCode: 0xFF26C6DA,
      ),
      Medicine(
        name: 'Burnol',
        dose: 'Apply',
        time: timeAt(12, 30),
        type: 'Cream',
        stock: 2,
        purpose: 'Burns',
        expiryDate: expiry,
        colorCode: 0xFFFF9800,
      ),

      // VITAMINS
      Medicine(
        name: 'Vitamin D3',
        dose: '2000 IU',
        time: timeAt(9, 0),
        type: 'Vitamins',
        stock: 90,
        purpose: 'Bone Health',
        expiryDate: expiry,
        mealInstruction: 'After Breakfast',
        colorCode: 0xFFFFD54F,
      ),
      Medicine(
        name: 'Vitamin C',
        dose: '1000 mg',
        time: timeAt(8, 30),
        type: 'Vitamins',
        stock: 60,
        purpose: 'Immunity',
        expiryDate: expiry,
        colorCode: 0xFFFFF176,
      ),
      Medicine(
        name: 'Vitamin B12',
        dose: '1000 mcg',
        time: timeAt(10, 0),
        type: 'Vitamins',
        stock: 30,
        purpose: 'Energy',
        expiryDate: expiry,
        colorCode: 0xFFF06292,
      ),
      Medicine(
        name: 'Calcium Tablets',
        dose: '500 mg',
        time: timeAt(21, 30),
        type: 'Vitamins',
        stock: 45,
        purpose: 'Bone Strength',
        expiryDate: expiry,
        colorCode: 0xFFE0E0E0,
      ),
      Medicine(
        name: 'Omega 3',
        dose: '1000 mg',
        time: timeAt(19, 30),
        type: 'Vitamins',
        stock: 60,
        purpose: 'Heart Health',
        expiryDate: expiry,
        colorCode: 0xFF90CAF9,
      ),
      Medicine(
        name: 'Zinc Tablets',
        dose: '50 mg',
        time: timeAt(20, 0),
        type: 'Vitamins',
        stock: 30,
        purpose: 'Immunity',
        expiryDate: expiry,
        colorCode: 0xFFB0BEC5,
      ),

      // FIRST AID
      Medicine(
        name: 'Bandage Roll',
        dose: '1 Unit',
        time: timeAt(12, 0),
        type: 'First Aid',
        stock: 5,
        purpose: 'Wound Dressing',
        expiryDate: expiry,
        colorCode: 0xFFFFFFFF,
      ),
      Medicine(
        name: 'Antiseptic Liquid',
        dose: '5 ml',
        time: timeAt(14, 0),
        type: 'First Aid',
        stock: 2,
        purpose: 'Cleaning Wounds',
        expiryDate: expiry,
        colorCode: 0xFF64B5F6,
      ),
      Medicine(
        name: 'Cotton Swabs',
        dose: '2-3 Units',
        time: timeAt(13, 0),
        type: 'First Aid',
        stock: 100,
        purpose: 'Application',
        expiryDate: expiry,
        colorCode: 0xFFFAFAFA,
      ),
      Medicine(
        name: 'Dettol',
        dose: '10 ml',
        time: timeAt(11, 30),
        type: 'First Aid',
        stock: 1,
        purpose: 'Antiseptic',
        expiryDate: expiry,
        colorCode: 0xFF8BC34A,
      ),

      // HERBS
      Medicine(
        name: 'Ashwagandha',
        dose: '300 mg',
        time: timeAt(21, 0),
        type: 'Herbs',
        stock: 60,
        purpose: 'Stress Relief',
        expiryDate: expiry,
        colorCode: 0xFF9CCC65,
      ),
      Medicine(
        name: 'Turmeric Capsule',
        dose: '500 mg',
        time: timeAt(20, 0),
        type: 'Herbs',
        stock: 45,
        purpose: 'Anti-inflammatory',
        expiryDate: expiry,
        colorCode: 0xFFD4E157,
      ),
      Medicine(
        name: 'Giloy Juice',
        dose: '30 ml',
        time: timeAt(7, 0),
        type: 'Herbs',
        stock: 2,
        purpose: 'Immunity Booster',
        expiryDate: expiry,
        beforeFood: true,
        colorCode: 0xFFAED581,
      ),
      Medicine(
        name: 'Tulsi Drops',
        dose: '5 Drops',
        time: timeAt(6, 30),
        type: 'Herbs',
        stock: 1,
        purpose: 'Respiratory Health',
        expiryDate: expiry,
        colorCode: 0xFF81C784,
      ),
      Medicine(
        name: 'Triphala Churna',
        dose: '1 tsp',
        time: timeAt(22, 30),
        type: 'Herbs',
        stock: 1,
        purpose: 'Digestion',
        expiryDate: expiry,
        colorCode: 0xFF8D6E63,
      ),

      // TESTS
      Medicine(
        name: 'Blood Glucose Test',
        dose: 'Fasting',
        time: timeAt(7, 0),
        type: 'Tests',
        stock: 25,
        purpose: 'Diabetes Monitoring',
        expiryDate: expiry,
        beforeFood: true,
        colorCode: 0xFFE57373,
      ),
      Medicine(
        name: 'Blood Pressure Check',
        dose: 'Reading',
        time: timeAt(8, 0),
        type: 'Tests',
        stock: 1,
        purpose: 'BP Monitoring',
        expiryDate: expiry,
        colorCode: 0xFFBA68C8,
      ),
      Medicine(
        name: 'Temperature Check',
        dose: 'Reading',
        time: timeAt(6, 0),
        type: 'Tests',
        stock: 1,
        purpose: 'Fever Monitoring',
        expiryDate: expiry,
        colorCode: 0xFFF06292,
      ),
      Medicine(
        name: 'Pulse Oximeter',
        dose: 'Reading',
        time: timeAt(9, 30),
        type: 'Tests',
        stock: 1,
        purpose: 'Oxygen Level',
        expiryDate: expiry,
        colorCode: 0xFF64B5F6,
      ),
    ];

    box.addAll(initialMedicines);
  }

  bool isDoseTaken(String medicineId, DateTime scheduledTime) {
    final now = DateTime.now();
    return doseLogs.any(
      (log) =>
          log.medicineId == medicineId &&
          log.scheduledTime.hour == scheduledTime.hour &&
          log.scheduledTime.minute == scheduledTime.minute &&
          log.scheduledTime.year == now.year &&
          log.scheduledTime.month == now.month &&
          log.scheduledTime.day == now.day,
    );
  }

  void addMedicine(Medicine medicine) {
    box.add(medicine);
    medicines.add(medicine);

    // Add to history
    final log = DoseLog(
      medicineId: medicine.id,
      medicineName: medicine.name,
      scheduledTime: DateTime.now(),
      actualTime: DateTime.now(),
      isTaken: true,
      note: 'Medication added to schedule',
    );
    logsBox.add(log);
    doseLogs.add(log);

    _sortMedicines();
    _scheduleNotifications(medicine);
    notifyListeners();
  }

  void updateMedicine(String id, Medicine updatedMedicine) {
    final index = medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      _cancelNotifications(medicines[index]);

      final key = medicines[index].key;
      box.put(key, updatedMedicine);
      medicines[index] = updatedMedicine;
      _sortMedicines();
      _scheduleNotifications(updatedMedicine);

      notifyListeners();
    }
  }

  void deleteMedicine(String id) {
    final index = medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      _cancelNotifications(medicines[index]);
      medicines[index].delete();
      medicines.removeAt(index);
      notifyListeners();
    }
  }

  void toggleDose(String id, DateTime scheduledTime) {
    final now = DateTime.now();
    final index = medicines.indexWhere((m) => m.id == id);
    if (index == -1) return;

    final medicine = medicines[index];
    final logIndex = doseLogs.indexWhere(
      (log) =>
          log.medicineId == id &&
          log.scheduledTime.hour == scheduledTime.hour &&
          log.scheduledTime.minute == scheduledTime.minute &&
          log.scheduledTime.year == now.year &&
          log.scheduledTime.month == now.month &&
          log.scheduledTime.day == now.day,
    );

    if (logIndex != -1) {
      // Untake: Remove log and increase stock
      final log = doseLogs[logIndex];
      log.delete();
      doseLogs.removeAt(logIndex);

      final updated = medicine.copyWith(
        stock: medicine.stock + 1,
        lastTaken: null, // This is simplified, real app might need history
      );
      final key = medicine.key;
      box.put(key, updated);
      medicines[index] = updated;
    } else {
      // Take: Add log and decrease stock
      if (medicine.stock > 0) {
        final log = DoseLog(
          medicineId: id,
          medicineName: medicine.name,
          scheduledTime: scheduledTime,
          actualTime: DateTime.now(),
          isTaken: true,
          note: 'Dose taken manually',
        );
        logsBox.add(log);
        doseLogs.add(log);

        final updated = medicine.copyWith(
          stock: medicine.stock - 1,
          lastTaken: DateTime.now(),
        );
        final key = medicine.key;
        box.put(key, updated);
        medicines[index] = updated;
      }
    }
    notifyListeners();
  }

  void useOneDose(String id) {
    // Legacy support or specific use case, but toggleDose is preferred
    toggleDose(id, DateTime.now());
  }

  void addStock(String id, int amount) {
    final index = medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updated = medicines[index].copyWith(
        stock: medicines[index].stock + amount,
      );
      final key = medicines[index].key;
      box.put(key, updated);
      medicines[index] = updated;
      notifyListeners();
    }
  }

  void _sortMedicines() {
    medicines.sort((a, b) {
      final hourComp = a.time.hour.compareTo(b.time.hour);
      if (hourComp != 0) return hourComp;
      return a.time.minute.compareTo(b.time.minute);
    });
  }

  void _scheduleNotifications(Medicine medicine) {
    // Keeping logic but ignoring for now as per user requested "No reminder focus"
  }

  void _cancelNotifications(Medicine medicine) {
    // Keeping logic but ignoring for now
  }
}
