import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> appointments = [];
  final box = Hive.box<Appointment>('appointments');

  AppointmentProvider() {
    loadAppointments();
  }

  void loadAppointments() {
    appointments = box.values.toList();
    appointments.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  void addAppointment(Appointment appointment) {
    box.add(appointment);
    appointments.add(appointment);
    appointments.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  void deleteAppointment(String id) {
    final index = appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      appointments[index].delete();
      appointments.removeAt(index);
      notifyListeners();
    }
  }

  Appointment? getNextAppointment() {
    final now = DateTime.now();
    try {
      return appointments.firstWhere((a) => a.date.isAfter(now));
    } catch (e) {
      return null;
    }
  }
}
