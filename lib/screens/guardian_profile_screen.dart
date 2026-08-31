import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'connect_patient_screen.dart';

class GuardianProfileScreen extends StatefulWidget {
  const GuardianProfileScreen({super.key});

  @override
  State<GuardianProfileScreen> createState() =>
      _GuardianProfileScreenState();
}

class _GuardianProfileScreenState
    extends State<GuardianProfileScreen> {
  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  String? _selectedRelationship;

  final List<String> _relationships = [
    'Parent',
    'Spouse',
    'Sibling',
    'Child',
    'Relative',
    'Caregiver',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // =============================================================
  // CONTINUE
  // =============================================================

  void _continue() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      _showMessage('Please enter your full name.');
      return;
    }

    if (phone.isEmpty) {
      _showMessage('Please enter your phone number.');
      return;
    }

    if (_selectedRelationship == null) {
      _showMessage('Please select your relationship.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConnectPatientScreen(),
      ),
    );
  }

  // =============================================================
  // MESSAGE
  // =============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            22,
            18,
            22,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // BACK BUTTON
              // =================================================

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppTheme.navy,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
              ),

              const SizedBox(height: 12),

              // =================================================
              // PROGRESS
              // =================================================

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDE7E7),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =================================================
              // HEADER ICON
              // =================================================

              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E9F8),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE1D2F1),
                    ),
                  ),
                  child: const Icon(
                    Icons.people_alt_rounded,
                    color: Color(0xFF8B5FBF),
                    size: 39,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Set up your profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Tell us a little about yourself so '
                      'we can help you stay connected to '
                      'someone you care for.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13.5,
                    height: 1.45,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // PROFILE CARD
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.035,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your details',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // NAME
                    // -------------------------------------------------

                    _buildLabel('Full name'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: _nameController,
                      textInputAction:
                      TextInputAction.next,
                      decoration: _inputDecoration(
                        hint: 'Enter your full name',
                        icon:
                        Icons.person_outline_rounded,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // PHONE
                    // -------------------------------------------------

                    _buildLabel('Phone number'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: _phoneController,
                      keyboardType:
                      TextInputType.phone,
                      textInputAction:
                      TextInputAction.next,
                      decoration: _inputDecoration(
                        hint: 'Enter your phone number',
                        icon:
                        Icons.phone_outlined,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // -------------------------------------------------
                    // RELATIONSHIP
                    // -------------------------------------------------

                    _buildLabel(
                      'Relationship with the patient',
                    ),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      initialValue:
                      _selectedRelationship,
                      decoration: _inputDecoration(
                        hint:
                        'Select your relationship',
                        icon:
                        Icons.family_restroom_rounded,
                      ),
                      items: _relationships
                          .map(
                            (relationship) =>
                            DropdownMenuItem<String>(
                              value: relationship,
                              child:
                              Text(relationship),
                            ),
                      )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRelationship =
                              value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =================================================
              // GUARDIAN PURPOSE CARD
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EFF9),
                  borderRadius:
                  BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFE4D8F0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.visibility_outlined,
                        color: Color(0xFF8B5FBF),
                        size: 25,
                      ),
                    ),

                    const SizedBox(width: 13),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stay informed, not intrusive',
                            style: TextStyle(
                              color: AppTheme.navy,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'You will only be able to see the '
                                'information the patient chooses '
                                'to share with you.',
                            style: TextStyle(
                              color:
                              AppTheme.textSecondary,
                              fontSize: 11.5,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =================================================
              // CONNECTION PREVIEW
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F6),
                  borderRadius:
                  BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFD2EEEC),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.link_rounded,
                          color: AppTheme.primary,
                          size: 23,
                        ),
                        SizedBox(width: 9),
                        Text(
                          'Next: Connect to a patient',
                          style: TextStyle(
                            color: AppTheme.navy,
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w800,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 9),

                    const Text(
                      'After creating your profile, you can '
                          'connect to a patient using their unique '
                          'CareBridge connection code.',
                      style: TextStyle(
                        color:
                        AppTheme.textSecondary,
                        fontSize: 11.5,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 13),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color:
                            Color(0xFF2E9B68),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'The patient must approve the connection.',
                              style: TextStyle(
                                color:
                                AppTheme.navy,
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // PRIVACY
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: const Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: Color(0xFF2E9B68),
                      size: 21,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'The patient controls what health '
                            'information is shared with you.',
                        style: TextStyle(
                          color:
                          AppTheme.textSecondary,
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // CONTINUE BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
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

              const SizedBox(height: 18),

              const Center(
                child: Text(
                  'Step 1 of 3',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'CareBridge • Your health, connected.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // LABEL
  // =============================================================

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppTheme.navy,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // =============================================================
  // INPUT DECORATION
  // =============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFFF6F9F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: AppTheme.primary,
          width: 1.4,
        ),
      ),
    );
  }
}