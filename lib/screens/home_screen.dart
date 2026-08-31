import 'package:flutter/material.dart';

import '../models/care_task.dart';
import '../services/home_service.dart';
import '../theme/app_theme.dart';
import 'connection_requests_screen.dart';
import 'scan_instructions_screen.dart';

class HomeScreen extends StatefulWidget {
  final String patientName;

  const HomeScreen({
    super.key,
    this.patientName = 'there',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =============================================================
  // COMPLETE NEXT TASK
  // =============================================================

  void _completeNextTask() {
    final nextTask = HomeService.getNextTask();

    if (nextTask == null) {
      return;
    }

    HomeService.completeTask(nextTask.id);

    setState(() {});
  }

  // =============================================================
  // OPEN SCAN INSTRUCTIONS
  // =============================================================

  void _openScanInstructions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScanInstructionsScreen(),
      ),
    );
  }

  // =============================================================
  // OPEN CONNECTION REQUESTS
  // =============================================================

  void _openConnectionRequests() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConnectionRequestsScreen(),
      ),
    );
  }

  // =============================================================
  // GET TIME-BASED GREETING
  // =============================================================

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning';
    }

    if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  // =============================================================
  // GET GREETING ICON
  // =============================================================

  String _getGreetingEmoji() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return '🌅';
    }

    if (hour >= 12 && hour < 17) {
      return '☀️';
    }

    return '🌙';
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = HomeService.getCompletedTasks();
    final totalTasks = HomeService.getTotalTasks();
    final progress = HomeService.getProgress();
    final nextTask = HomeService.getNextTask();

    return Scaffold(
      backgroundColor: AppTheme.background,

      // ---------------------------------------------------------
      // BOTTOM NAVIGATION
      // ---------------------------------------------------------

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.white,
        indicatorColor:
        AppTheme.primary.withValues(alpha: 0.12),
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

      // ---------------------------------------------------------
      // MAIN BODY
      // ---------------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -------------------------------------------------
              // APP NAME + CONNECTION ICON
              // -------------------------------------------------

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'CareBridge',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.navy,
                      ),
                    ),
                  ),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(15),
                      onTap: _openConnectionRequests,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFEAF7F6),
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.people_alt_outlined,
                          color: AppTheme.primary,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // -------------------------------------------------
              // DYNAMIC GREETING
              // -------------------------------------------------

              _buildGreetingBanner(),

              const SizedBox(height: 24),

              // -------------------------------------------------
              // CONNECTION BANNER
              // -------------------------------------------------

              _buildConnectionBanner(),

              const SizedBox(height: 24),

              // -------------------------------------------------
              // HELP SECTION
              // -------------------------------------------------

              const Text(
                'How can we help?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),

              const SizedBox(height: 14),

              // -------------------------------------------------
              // SCAN INSTRUCTIONS
              // -------------------------------------------------

              _ActionCard(
                icon: Icons.document_scanner_outlined,
                title: 'Scan Instructions',
                subtitle:
                'Scan your prescription or discharge instructions',
                color: const Color(0xFF2D8CFF),
                onTap: _openScanInstructions,
              ),

              const SizedBox(height: 12),

              // -------------------------------------------------
              // CARE PLAN
              // -------------------------------------------------

              _ActionCard(
                icon: Icons.assignment_outlined,
                title: 'My Care Plan',
                subtitle:
                "View today's care tasks and instructions",
                color: const Color(0xFF2E9B68),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Care Plan will be connected next.',
                      ),
                      behavior:
                      SnackBarBehavior.floating,
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // -------------------------------------------------
              // ASK CAREBRIDGE
              // -------------------------------------------------

              _ActionCard(
                icon: Icons.mic_none_outlined,
                title: 'Ask CareBridge',
                subtitle:
                'Ask questions using your voice',
                color: const Color(0xFF8B5FBF),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Ask CareBridge will be connected later.',
                      ),
                      behavior:
                      SnackBarBehavior.floating,
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // -------------------------------------------------
              // PROGRESS
              // -------------------------------------------------

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

              // -------------------------------------------------
              // NEXT TASK
              // -------------------------------------------------

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

  // =============================================================
  // CONNECTION BANNER
  // =============================================================

  Widget _buildConnectionBanner() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openConnectionRequests,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFF1EBF8),
                Color(0xFFF8F4FB),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE5D9F1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.people_alt_rounded,
                  color: Color(0xFF8B5FBF),
                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Family & Guardians',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage who can track your shared progress',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF8B5FBF),
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // DYNAMIC GREETING BANNER
  // =============================================================

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
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            '${_getGreeting()}, ${widget.patientName} '
                '${_getGreetingEmoji()}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Let's take care of you today.",
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),

          const SizedBox(height: 18),

          const Row(
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

  // =============================================================
  // PROGRESS CARD
  // =============================================================

  Widget _buildProgressCard(
      int completed,
      int total,
      double progress,
      ) {
    final percentage =
    (progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
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
            borderRadius:
            BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor:
              const Color(0xFFE8ECEC),
              valueColor:
              const AlwaysStoppedAnimation<Color>(
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

  // =============================================================
  // NEXT TASK CARD
  // =============================================================

  Widget _buildNextTaskCard(CareTask task) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(
                alpha: 0.12,
              ),
              borderRadius:
              BorderRadius.circular(16),
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
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w700,
                    color: AppTheme.navy,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  task.time,
                  style: const TextStyle(
                    color:
                    AppTheme.textSecondary,
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

  // =============================================================
  // COMPLETED CARD
  // =============================================================

  Widget _buildCompletedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7EF),
        borderRadius:
        BorderRadius.circular(22),
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

// ===============================================================
// ACTION CARD
// ===============================================================

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
      borderRadius:
      BorderRadius.circular(22),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                  BorderRadius.circular(18),
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w700,
                        color: AppTheme.navy,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color:
                        AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color:
                AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}