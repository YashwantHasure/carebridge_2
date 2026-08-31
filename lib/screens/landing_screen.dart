import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildTopBar(),
              _buildHeroSection(context),
              const SizedBox(height: 26),
              _buildQuickIntro(),
              const SizedBox(height: 26),
              _buildFeatures(),
              const SizedBox(height: 26),
              _buildConnectionCard(),
              const SizedBox(height: 20),
              _buildPrivacyCard(),
              const SizedBox(height: 26),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // TOP BAR
  // =============================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        22,
        18,
        22,
        8,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppTheme.primary,
                  Color(0xFF32BDB4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(
                    alpha: 0.22,
                  ),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CareBridge',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your health, connected.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE4EBEB),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: Color(0xFF2E9B68),
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  'Secure',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // HERO
  // =============================================================

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        18,
        20,
        0,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          22,
          25,
          22,
          24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0C8F89),
              Color(0xFF36BEB5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(
                alpha: 0.20,
              ),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 205,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 4,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.10,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 12,
                    child: _buildFloatingBubble(
                      Icons.medication_outlined,
                      'Care',
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 5,
                    child: _buildFloatingBubble(
                      Icons.favorite_rounded,
                      'Health',
                    ),
                  ),

                  Container(
                    width: 145,
                    height: 145,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8FAF8),
                            borderRadius:
                            BorderRadius.circular(32),
                          ),
                        ),

                        const Icon(
                          Icons.health_and_safety_rounded,
                          color: AppTheme.primary,
                          size: 70,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'Care made simpler.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 31,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Understand. Manage. Connect.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE4FFFD),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'A smarter way to understand your care, '
                  'stay on track and keep your trusted '
                  'family members connected.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 22),

            // =================================================
            // GET STARTED → LOGIN
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const LoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 9),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 21,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // FLOATING BUBBLE
  // =============================================================

  Widget _buildFloatingBubble(
      IconData icon,
      String label,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.94,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.10,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 17,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.navy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // QUICK INTRO
  // =============================================================

  Widget _buildQuickIntro() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Row(
        children: [
          Expanded(
            child: _InfoPill(
              icon: Icons.document_scanner_outlined,
              title: 'Scan',
              subtitle: 'Your documents',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _InfoPill(
              icon: Icons.task_alt_rounded,
              title: 'Track',
              subtitle: 'Your care',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _InfoPill(
              icon: Icons.people_outline_rounded,
              title: 'Connect',
              subtitle: 'Your family',
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // FEATURES
  // =============================================================

  Widget _buildFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Built around your care',
              style: TextStyle(
                color: AppTheme.navy,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 14),

          _FeatureCard(
            icon: Icons.document_scanner_outlined,
            title: 'Understand your instructions',
            description:
            'Scan prescriptions and discharge documents '
                'and turn complex information into simple '
                'care instructions.',
            color: const Color(0xFF2D8CFF),
          ),

          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.check_circle_outline_rounded,
            title: 'Stay on track',
            description:
            'Keep track of medications, activities and '
                'important daily care tasks in one place.',
            color: const Color(0xFF2E9B68),
          ),

          const SizedBox(height: 12),

          _FeatureCard(
            icon: Icons.people_outline_rounded,
            title: 'Keep your family connected',
            description:
            'Authorized family members can follow your '
                'care progress and stay informed.',
            color: const Color(0xFF8B5FBF),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // CONNECTION CARD
  // =============================================================

  Widget _buildConnectionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF172B4D),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.family_restroom_rounded,
                color: Color(0xFF9CE9E4),
                size: 30,
              ),
            ),

            const SizedBox(width: 15),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Care is better together',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Stay connected with the people you trust.',
                    style: TextStyle(
                      color: Color(0xFFC7D2E3),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF9CE9E4),
              size: 17,
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // PRIVACY
  // =============================================================

  Widget _buildPrivacyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF7F0),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: const Color(0xFFD5EFDF),
          ),
        ),
        child: const Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              color: Color(0xFF2E9B68),
              size: 24,
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your privacy matters',
                    style: TextStyle(
                      color: AppTheme.navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your health information stays private '
                        'and is shared only with people you authorize.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12.5,
                      height: 1.45,
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

  // =============================================================
  // FOOTER
  // =============================================================

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 24,
      ),
      child: Column(
        children: [
          Text(
            'CareBridge',
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your health, connected.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// INFO PILL
// ===============================================================

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoPill({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 23,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.navy,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// FEATURE CARD
// ===============================================================

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius:
              BorderRadius.circular(17),
            ),
            child: Icon(
              icon,
              color: color,
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
                  title,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}