import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() =>
      _PatientProfileScreenState();
}

class _PatientProfileScreenState
    extends State<PatientProfileScreen> {
  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _phoneController =
  TextEditingController();

  final TextEditingController _emergencyNameController =
  TextEditingController();

  final TextEditingController _emergencyPhoneController =
  TextEditingController();

  DateTime? _dateOfBirth;

  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime now = DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        now.year - 25,
        now.month,
        now.day,
      ),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppTheme.navy,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _dateOfBirth = selectedDate;
      });
    }
  }

  // =============================================================
  // CONTINUE TO HOME
  // =============================================================

  void _continue() {
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (name.isEmpty) {
      _showMessage('Please enter your full name.');
      return;
    }

    if (_dateOfBirth == null) {
      _showMessage('Please select your date of birth.');
      return;
    }

    if (phone.isEmpty) {
      _showMessage('Please enter your phone number.');
      return;
    }

    // -----------------------------------------------------------
    // Profile information is validated.
    //
    // Backend/profile storage will be connected later.
    // For the prototype, continue directly to the Home screen.
    // -----------------------------------------------------------

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
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

  // =============================================================
  // DATE FORMAT
  // =============================================================

  String _formatDate(DateTime date) {
    final String day =
    date.day.toString().padLeft(2, '0');

    final String month =
    date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
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
              // HEADER
              // =================================================

              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F8F6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC9EFEB),
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: AppTheme.primary,
                    size: 40,
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
                      'CareBridge can personalize your experience.',
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
              // PERSONAL DETAILS CARD
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
                      'Personal details',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 18),

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

                    _buildLabel('Date of birth'),

                    const SizedBox(height: 7),

                    InkWell(
                      onTap: _selectDateOfBirth,
                      borderRadius:
                      BorderRadius.circular(17),
                      child: Container(
                        width: double.infinity,
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 17,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFF6F9F9),
                          borderRadius:
                          BorderRadius.circular(17),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons
                                  .calendar_month_outlined,
                              color:
                              AppTheme.textSecondary,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                _dateOfBirth == null
                                    ? 'Select your date of birth'
                                    : _formatDate(
                                  _dateOfBirth!,
                                ),
                                style: TextStyle(
                                  color:
                                  _dateOfBirth ==
                                      null
                                      ? AppTheme
                                      .textSecondary
                                      : AppTheme.navy,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                            const Icon(
                              Icons
                                  .keyboard_arrow_down_rounded,
                              color:
                              AppTheme.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Gender'),

                    const SizedBox(height: 7),

                    DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      decoration: _inputDecoration(
                        hint: 'Select gender',
                        icon: Icons.wc_outlined,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                        DropdownMenuItem(
                          value: 'Prefer not to say',
                          child: Text(
                            'Prefer not to say',
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Phone number'),

                    const SizedBox(height: 7),

                    TextField(
                      controller: _phoneController,
                      keyboardType:
                      TextInputType.phone,
                      textInputAction:
                      TextInputAction.next,
                      decoration: _inputDecoration(
                        hint:
                        'Enter your phone number',
                        icon:
                        Icons.phone_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // =================================================
              // EMERGENCY CONTACT
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8ED),
                  borderRadius:
                  BorderRadius.circular(26),
                  border: Border.all(
                    color: const Color(0xFFF5E4C5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFFFFEDCE),
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons
                                .contact_phone_outlined,
                            color:
                            Color(0xFFD18A19),
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Emergency contact',
                                style: TextStyle(
                                  color:
                                  AppTheme.navy,
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Optional',
                                style: TextStyle(
                                  color: AppTheme
                                      .textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildLabel('Contact name'),

                    const SizedBox(height: 7),

                    TextField(
                      controller:
                      _emergencyNameController,
                      textInputAction:
                      TextInputAction.next,
                      decoration: _inputDecoration(
                        hint:
                        'Enter emergency contact name',
                        icon:
                        Icons.person_outline_rounded,
                        fillColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 14),

                    _buildLabel('Contact phone'),

                    const SizedBox(height: 7),

                    TextField(
                      controller:
                      _emergencyPhoneController,
                      keyboardType:
                      TextInputType.phone,
                      decoration: _inputDecoration(
                        hint:
                        'Enter emergency contact number',
                        icon:
                        Icons.phone_outlined,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // PRIVACY NOTE
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
                        'You control what information is shared '
                            'with your family members or guardians.',
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
                        'Continue to CareBridge',
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
                  'Step 2 of 3',
                  style: TextStyle(
                    color:
                    AppTheme.textSecondary,
                    fontSize: 11,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'CareBridge • Your health, connected.',
                  style: TextStyle(
                    color:
                    AppTheme.textSecondary,
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
    Color? fillColor,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor:
      fillColor ?? const Color(0xFFF6F9F9),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: AppTheme.primary,
          width: 1.4,
        ),
      ),
    );
  }
}