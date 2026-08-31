import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ConnectPatientScreen extends StatefulWidget {
  const ConnectPatientScreen({super.key});

  @override
  State<ConnectPatientScreen> createState() =>
      _ConnectPatientScreenState();
}

class _ConnectPatientScreenState
    extends State<ConnectPatientScreen> {
  final TextEditingController _codeController =
  TextEditingController();

  bool _requestSent = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _connectPatient() {
    final code = _codeController.text
        .trim()
        .toUpperCase();

    if (code.isEmpty) {
      _showMessage(
        'Please enter the patient connection code.',
      );
      return;
    }

    if (!_isValidCode(code)) {
      _showMessage(
        'Enter a valid CareBridge code like CB-48291.',
      );
      return;
    }

    setState(() {
      _requestSent = true;
    });
  }

  bool _isValidCode(String code) {
    final RegExp pattern =
    RegExp(r'^CB-[A-Z0-9]{5}$');

    return pattern.hasMatch(code);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetConnection() {
    setState(() {
      _requestSent = false;
      _codeController.clear();
    });
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
            crossAxisAlignment:
            CrossAxisAlignment.start,
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
                        color: AppTheme.primary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // =================================================
              // HEADER
              // =================================================

              Center(
                child: Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE9F9F7),
                        Color(0xFFDDF4F1),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC8EBE7),
                    ),
                  ),
                  child: const Icon(
                    Icons.link_rounded,
                    color: AppTheme.primary,
                    size: 43,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Connect to a patient',
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
                  'Enter the unique CareBridge code '
                      'provided by the patient.',
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
              // CONNECTION CARD
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
                      'Patient connection code',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Text(
                      'Ask the patient to share their '
                          'CareBridge connection code with you.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 17),

                    TextField(
                      controller: _codeController,
                      enabled: !_requestSent,
                      textCapitalization:
                      TextCapitalization.characters,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppTheme.navy,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                      decoration: InputDecoration(
                        hintText: 'CB-48291',
                        hintStyle: TextStyle(
                          color: AppTheme.textSecondary
                              .withValues(alpha: 0.45),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                        prefixIcon: const Icon(
                          Icons.vpn_key_outlined,
                        ),
                        filled: true,
                        fillColor:
                        const Color(0xFFF6F9F9),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                          borderSide:
                          const BorderSide(
                            color: AppTheme.primary,
                            width: 1.5,
                          ),
                        ),
                        disabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    if (!_requestSent)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed:
                          _connectPatient,
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            AppTheme.primary,
                            foregroundColor:
                            Colors.white,
                            elevation: 0,
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                17,
                              ),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                'Send Connection Request',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight:
                                  FontWeight.w800,
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

              const SizedBox(height: 18),

              // =================================================
              // REQUEST STATUS
              // =================================================

              AnimatedSwitcher(
                duration:
                const Duration(milliseconds: 250),
                child: _requestSent
                    ? _buildRequestSentCard()
                    : _buildHowItWorksCard(),
              ),

              const SizedBox(height: 18),

              // =================================================
              // PRIVACY
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius:
                  BorderRadius.circular(21),
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
                        'Your access is controlled by the patient. '
                            'You cannot view their health information '
                            'until they approve your request.',
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

              const SizedBox(height: 24),

              const Center(
                child: Text(
                  'Step 2 of 3',
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
  // HOW IT WORKS
  // =============================================================

  Widget _buildHowItWorksCard() {
    return Container(
      key: const ValueKey('how_it_works'),
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE4D8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF8B5FBF),
                size: 23,
              ),
              SizedBox(width: 9),
              Text(
                'How it works',
                style: TextStyle(
                  color: AppTheme.navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          _buildStep(
            number: '1',
            title: 'Get the patient code',
            description:
            'The patient can find their unique '
                'connection code in CareBridge.',
          ),

          const SizedBox(height: 12),

          _buildStep(
            number: '2',
            title: 'Enter the code',
            description:
            'Enter the code above to send a '
                'connection request.',
          ),

          const SizedBox(height: 12),

          _buildStep(
            number: '3',
            title: 'Wait for approval',
            description:
            'The patient decides whether to approve '
                'your connection.',
          ),
        ],
      ),
    );
  }

  // =============================================================
  // REQUEST SENT CARD
  // =============================================================

  Widget _buildRequestSentCard() {
    return Container(
      key: const ValueKey('request_sent'),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7F0),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFD1EDDE),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFD8F1E3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF2E9B68),
              size: 34,
            ),
          ),

          const SizedBox(height: 13),

          const Text(
            'Request sent!',
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'The patient needs to approve your '
                'connection request before you can '
                'view their shared progress.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.hourglass_top_rounded,
                  color: Color(0xFFD18A19),
                  size: 20,
                ),

                const SizedBox(width: 9),

                const Expanded(
                  child: Text(
                    'Waiting for patient approval',
                    style: TextStyle(
                      color: AppTheme.navy,
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                ),

                Container(
                  width: 9,
                  height: 9,
                  decoration:
                  const BoxDecoration(
                    color: Color(0xFFD18A19),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          TextButton(
            onPressed: _resetConnection,
            child: const Text(
              'Use a different code',
              style: TextStyle(
                color: AppTheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // STEP
  // =============================================================

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          width: 29,
          height: 29,
          decoration: BoxDecoration(
            color: const Color(0xFFE5D9F1),
            borderRadius:
            BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Color(0xFF8B5FBF),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.navy,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}