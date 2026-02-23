import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/doctor_model.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> doctors = [];
  final box = Hive.box<Doctor>('doctors');

  DoctorProvider() {
    loadDoctors();
  }

  void loadDoctors() {
    doctors = box.values.toList();
    if (doctors.isEmpty) {
      seedDemoData();
    } else {
      notifyListeners();
    }
  }

  void seedDemoData() {
    final demoDoctors = [
      Doctor(
        name: 'Dr. Sameer Kulkarni',
        specialty: 'Cardiologist',
        contact: '+91 98765 43210',
      ),
      Doctor(
        name: 'Dr. Anjali Deshpande',
        specialty: 'General Physician',
        contact: '+91 98220 11223',
      ),
    ];
    for (var d in demoDoctors) {
      box.add(d);
      doctors.add(d);
    }
    notifyListeners();
  }

  void addDoctor(Doctor doctor) {
    box.add(doctor);
    doctors.add(doctor);
    notifyListeners();
  }

  void deleteDoctor(String id) {
    final index = doctors.indexWhere((d) => d.id == id);
    if (index != -1) {
      doctors[index].delete();
      doctors.removeAt(index);
      notifyListeners();
    }
  }
}
