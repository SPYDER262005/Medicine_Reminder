import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool isSearch;

  const EmptyStateWidget({Key? key, this.isSearch = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSearch ? Icons.search_off_rounded : Icons.medication_rounded,
              size: 100,
              color: AppColors.primary.withOpacity(0.5),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut),
          
          const SizedBox(height: 32),
          
          Text(
            isSearch ? 'No Results Found' : 'Your Schedule is Empty',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          Text(
            isSearch 
                ? 'We couldn\'t find any medicine matching your search. Try a different name.'
                : 'Start your healthy journey by adding your first medication reminder.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ).animate().fadeIn(duration: 800.ms),
    );
  }
}
