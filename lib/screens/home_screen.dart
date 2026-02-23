import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine_model.dart';
import '../core/time_helper.dart';
import 'add_medicine_screen.dart';
import 'category_screen.dart';
import 'health_guide_screen.dart';
import 'emergency_screen.dart';
import 'schedule_screen.dart';
import 'history_screen.dart';
import 'more_screen.dart';
import 'medicine_detail_screen.dart';
import '../providers/appointment_provider.dart';
import '../providers/doctor_provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTabChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      _HomeContent(onTabChanged: _onTabChanged),
      const ScheduleScreen(),
      const HistoryScreen(),
      const MoreScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _selectedIndex, children: screens),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex == 0
          ? Container(
              height: 48,
              width: 48,
              margin: const EdgeInsets.only(top: 24),
              child: FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddMedicineScreen()),
                ),
                backgroundColor: const Color(0xFFE8F2FF),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Color(0xFF003061),
                  size: 24,
                ),
              ),
            ).animate().scale(delay: 400.ms)
          : null,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Home'),
            _buildNavItem(1, Icons.explore_outlined, 'Explore'),
            const SizedBox(width: 48), // Spacer for FAB
            _buildNavItem(2, Icons.history_rounded, 'History'),
            _buildNavItem(3, Icons.grid_view_rounded, 'More'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textHint,
              size: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.primary : AppColors.textHint,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final Function(int) onTabChanged;
  const _HomeContent({Key? key, required this.onTabChanged}) : super(key: key);

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final user = AuthService().currentUser;
    String displayName = 'User';
    if (user != null && user.email != null) {
      final email = user.email!;
      final localPart = email.split('@')[0].replaceAll(RegExp(r'[0-9]'), '');
      if (localPart.length > 5) {
        const surnames = ['sharma', 'kumar', 'singh', 'patel', 'das', 'gupta'];
        bool found = false;
        for (var s in surnames) {
          if (localPart.toLowerCase().startsWith(s)) {
            final firstName = localPart.substring(s.length);
            final lastName = s;
            displayName = '${_capitalize(firstName)} ${_capitalize(lastName)}';
            found = true;
            break;
          } else if (localPart.toLowerCase().endsWith(s)) {
            final firstName = localPart.substring(
              0,
              localPart.length - s.length,
            );
            final lastName = s;
            displayName = '${_capitalize(firstName)} ${_capitalize(lastName)}';
            found = true;
            break;
          }
        }
        if (!found) {
          displayName = _capitalize(localPart);
        }
      } else {
        displayName = _capitalize(localPart);
      }
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              8,
              MediaQuery.of(context).padding.top + 8,
              8,
              4,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => onTabChanged(3),
                  borderRadius: BorderRadius.circular(22),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, d MMMM').format(DateTime.now()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    padding: const EdgeInsets.all(8),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1)),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Dribbble Teal Hero Appointment Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF00C2A0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your upcoming doctor appointment date is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Consumer<AppointmentProvider>(
                  builder: (context, apptProvider, _) {
                    final nextAppt = apptProvider.getNextAppointment();
                    return Text(
                      nextAppt != null
                          ? DateFormat('d MMMM, yyyy').format(nextAppt.date)
                          : 'No appointments',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Consumer<DoctorProvider>(
                        builder: (context, doctorProvider, _) {
                          final doctor = doctorProvider.doctors.isNotEmpty
                              ? doctorProvider.doctors.first
                              : null;
                          return CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              'https://api.dicebear.com/7.x/avataaars/png?seed=${doctor?.name ?? "Jessica"}',
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Consumer<DoctorProvider>(
                        builder: (context, doctorProvider, _) {
                          final doctor = doctorProvider.doctors.isNotEmpty
                              ? doctorProvider.doctors.first
                              : null;
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor?.name ?? 'Dr. Jessica Smith',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  doctor?.specialty ?? 'Neurologist',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Consumer<AppointmentProvider>(
                        builder: (context, apptProvider, _) {
                          final nextAppt = apptProvider.getNextAppointment();
                          return Text(
                            nextAppt != null
                                ? DateFormat(
                                    'h.mm a',
                                  ).format(nextAppt.date).toLowerCase()
                                : '11.00 am',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Categories Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
            child: Text(
              'Quick Categories',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
        ),

        // Categories Section
        SliverToBoxAdapter(
          child: Container(
            height: 85,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildCategoryCard(
                  context,
                  'Pills',
                  Icons.medication_rounded,
                  Colors.orange,
                ),
                _buildCategoryCard(
                  context,
                  'Syrup',
                  Icons.water_drop_rounded,
                  Colors.blue,
                ),
                _buildCategoryCard(
                  context,
                  'Injection',
                  Icons.vaccines_rounded,
                  Colors.red,
                ),
                _buildCategoryCard(
                  context,
                  'Cream',
                  Icons.format_color_fill_rounded,
                  Colors.teal,
                ),
                _buildCategoryCard(
                  context,
                  'Vitamins',
                  Icons.wb_sunny_rounded,
                  Colors.amber,
                ),
                _buildCategoryCard(
                  context,
                  'First Aid',
                  Icons.medical_services_rounded,
                  Colors.green,
                ),
                _buildCategoryCard(
                  context,
                  'Herbs',
                  Icons.spa_rounded,
                  Colors.lightGreen,
                ),
                _buildCategoryCard(
                  context,
                  'Tests',
                  Icons.biotech_rounded,
                  Colors.purple,
                ),
              ],
            ),
          ),
        ),

        Selector<MedicineProvider, List<Medicine>>(
          selector: (_, p) => p.medicines,
          shouldRebuild: (prev, next) => prev.length != next.length,
          builder: (context, medicines, _) {
            if (medicines.isNotEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 24, 10, 12),
                  child: Row(
                    children: [
                      Text(
                        'Todays medicine',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${medicines.length} medicines',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),

        // Medicines Grid
        Consumer<MedicineProvider>(
          builder: (context, provider, _) {
            final medicines = provider.medicines;
            if (medicines.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.medication_liquid_rounded,
                        size: 64,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No medicines scheduled',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 900
                      ? 3
                      : (screenWidth > 600 ? 2 : 1),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: screenWidth > 600 ? 2.5 : 3.0,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _buildDribbbleMedicineCard(context, medicines[index]);
                }, childCount: medicines.length),
              ),
            );
          },
        ),

        // Bottom Banners
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 24, 8, 40),
            child: Column(
              children: [
                _buildHealthGuideBanner(context),
                const SizedBox(height: 12),
                _buildEmergencyKitBanner(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDribbbleMedicineCard(BuildContext context, Medicine medicine) {
    return Consumer<MedicineProvider>(
      builder: (context, provider, _) {
        final isTaken = provider.isDoseTaken(medicine.id, medicine.time);
        final medicineColor = Color(medicine.colorCode);
        final isMissed =
            !isTaken &&
            (DateTime.now().isAfter(
              medicine.time.add(const Duration(hours: 1)),
            ));

        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MedicineDetailScreen(medicine: medicine),
            ),
          ),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: medicineColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    'https://api.dicebear.com/7.x/shapes/png?seed=${medicine.name}',
                    errorBuilder: (_, __, ___) => Icon(
                      _getMedicineIcon(medicine.type),
                      color: medicineColor,
                    ),
                  ),git init
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        medicine.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${medicine.dose}, 1 pill',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 10,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            TimeHelper.format12Hour(medicine.time),
                            style: TextStyle(
                              color: isTaken
                                  ? Colors.green[600]
                                  : (isMissed
                                        ? Colors.red[600]
                                        : Colors.grey[500]),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isTaken
                                  ? Colors.green.withOpacity(0.1)
                                  : (isMissed
                                        ? Colors.red.withOpacity(0.1)
                                        : Colors.orange.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isTaken
                                  ? 'EAT'
                                  : (isMissed ? 'MISSED' : 'PENDING'),
                              style: TextStyle(
                                color: isTaken
                                    ? Colors.green
                                    : (isMissed ? Colors.red : Colors.orange),
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => provider.toggleDose(medicine.id, medicine.time),
                  child: AnimatedContainer(
                    duration: 300.ms,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isTaken
                          ? const Color(0xFF00C2A0)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isTaken
                            ? const Color(0xFF00C2A0)
                            : (isMissed
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3)),
                        width: 2,
                      ),
                    ),
                    child: isTaken
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18,
                          )
                        : (isMissed
                              ? const Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                  size: 18,
                                )
                              : null),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getMedicineIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pill':
      case 'tablet':
        return Icons.medication_rounded;
      case 'syrup':
        return Icons.water_drop_rounded;
      case 'injection':
        return Icons.vaccines_rounded;
      case 'cream':
        return Icons.format_color_fill_rounded;
      default:
        return Icons.medication_rounded;
    }
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 65,
      margin: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(categoryName: title),
          ),
        ),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ).animate().fadeIn().scale(),
    );
  }

  Widget _buildHealthGuideBanner(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HealthGuideScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.health_and_safety_rounded,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Health Guide',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Quick medical help',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyKitBanner(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EmergencyScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.12), width: 1.2),
        ),
        child: Row(
          children: [
            const Icon(Icons.emergency_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Emergency Kit',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Home essentials',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
