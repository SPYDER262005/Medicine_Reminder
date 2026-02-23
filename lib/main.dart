import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/medicine_model.dart';
import 'models/doctor_model.dart';
import 'models/health_record_model.dart';
import 'models/dose_log_model.dart';
import 'models/appointment_model.dart';
import 'providers/medicine_provider.dart';
import 'providers/doctor_provider.dart';
import 'providers/health_record_provider.dart';
import 'providers/history_provider.dart';
import 'providers/appointment_provider.dart';
import 'screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'core/notification_service.dart';
import 'core/app_theme.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Local storage initialization
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(MedicineAdapter());
  Hive.registerAdapter(DoctorAdapter());
  Hive.registerAdapter(HealthRecordAdapter());
  Hive.registerAdapter(DoseLogAdapter());
  Hive.registerAdapter(AppointmentAdapter());

  // Open Boxes
  await Hive.openBox<Medicine>('medicines');
  await Hive.openBox<Doctor>('doctors');
  await Hive.openBox<HealthRecord>('health_records');
  await Hive.openBox<DoseLog>('dose_logs');
  await Hive.openBox<Appointment>('appointments');

  // Notification service initialization
  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => HealthRecordProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MedAlert - Smart Medicine Reminder',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const HomeScreen();
        }

        return const OnboardingScreen();
      },
    );
  }
}
