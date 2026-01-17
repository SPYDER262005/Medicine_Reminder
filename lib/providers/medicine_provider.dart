import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/medicine_model.dart';
import '../core/notification_service.dart';

class MedicineProvider extends ChangeNotifier {
  List<Medicine> medicines = [];
  final box = Hive.box<Medicine>('medicines');

  MedicineProvider() {
    loadMedicines();
  }

  void loadMedicines() {
    medicines = box.values.toList();
    medicines.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void addMedicine(Medicine medicine) {
    box.add(medicine);
    medicines.add(medicine);
    medicines.sort((a, b) => a.time.compareTo(b.time));

    NotificationService.scheduleNotification(
      medicine.hashCode,
      'Medicine Reminder',
      '${medicine.name} - ${medicine.dose}',
      medicine.time,
    );

    notifyListeners();
  }

  void updateMedicine(String id, Medicine updatedMedicine) {
    final index = medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      // Cancel old notification
      NotificationService.cancelNotification(medicines[index].hashCode);
      
      // Update in Hive
      final key = medicines[index].key;
      box.put(key, updatedMedicine);
      
      // Update in list
      medicines[index] = updatedMedicine;
      medicines.sort((a, b) => a.time.compareTo(b.time));
      
      // Schedule new notification
      NotificationService.scheduleNotification(
        updatedMedicine.hashCode,
        'Medicine Reminder',
        '${updatedMedicine.name} - ${updatedMedicine.dose}',
        updatedMedicine.time,
      );
      
      notifyListeners();
    }
  }

  void deleteMedicine(String id) {
    final index = medicines.indexWhere((m) => m.id == id);
    if (index != -1) {
      // Cancel notification
      NotificationService.cancelNotification(medicines[index].hashCode);
      
      // Delete from Hive
      medicines[index].delete();
      
      // Remove from list
      medicines.removeAt(index);
      
      notifyListeners();
    }
  }
}
