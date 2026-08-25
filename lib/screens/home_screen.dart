import 'package:flutter/material.dart';
import '../models/care_task.dart';
import '../services/home_service.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _completeNextTask() {
    final nextTask = HomeService.getNextTask();

    if (nextTask == null) {
      return;
    }

    HomeService.completeTask(nextTask.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = HomeService.getCompletedTasks();
    final totalTasks = HomeService.getTotalTasks();
    final progress = HomeService.getProgress();
    final nextTask = HomeService.getNextTask();

    return Scaffold(
      backgroundColor: AppTheme.background,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.health_and_safety_outlined),
            selectedIcon: Icon(Icons.health_and_safety),
            label: 'Care',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CareBridge',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),

              const SizedBox(height: 18),

              _buildGreetingBanner(),

              const SizedBox(height: 24),

              const Text(
                'How can we help?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),

              const SizedBox(height: 14),

              _ActionCard(
                icon: Icons.document_scanner_outlined,
                title: 'Scan Instructions',
                subtitle:
                'Scan your prescription or discharge instructions',
                color: const Color(0xFF2D8CFF),
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _ActionCard(
                icon: Icons.assignment_outlined,
                title: 'My Care Plan',
                subtitle: "View today's care tasks and instructions",
                color: const Color(0xFF2E9B68),
                onTap: () {},
              ),

              const SizedBox(height: 12),

              _ActionCard(
                icon: Icons.mic_none_outlined,
                title: 'Ask CareBridge',
                subtitle: 'Ask questions using your voice',
                color: const Color(0xFF8B5FBF),
                onTap: () {},
              ),

              const SizedBox(height: 28),

              const Text(
                "Today's Progress",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),

              const SizedBox(height: 14),

              _buildProgressCard(
                completedTasks,
                totalTasks,
                progress,
              ),

              const SizedBox(height: 28),

              const Text(
                'Next Up',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),

              const SizedBox(height: 14),

              if (nextTask != null)
                _buildNextTaskCard(nextTask)
              else
                _buildCompletedCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE5F9F7),
            Color(0xFFDDF4F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good evening 👋',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Let's take care of you today.",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(
                Icons.favorite_rounded,
                color: AppTheme.primary,
                size: 17,
              ),
              SizedBox(width: 7),
              Text(
                'Your health matters',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
      int completed,
      int total,
      double progress,
      ) {
    final percentage = (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$completed of $total tasks completed',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: const Color(0xFFE8ECEC),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppTheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            progress >= 1.0
                ? 'Amazing! You completed everything today.'
                : 'Great job! Keep following your care plan.',
            style: const TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextTaskCard(CareTask task) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: AppTheme.primary,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.time,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: 'Complete task',
            onPressed: _completeNextTask,
            icon: const Icon(
              Icons.check_circle_outline,
              color: AppTheme.primary,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7EF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.celebration_outlined,
            color: Color(0xFF2E9B68),
            size: 34,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'All your care tasks are completed for today!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppTheme.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}