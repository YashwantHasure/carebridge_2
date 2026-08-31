import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_theme.dart';

class ScanInstructionsScreen extends StatefulWidget {
  const ScanInstructionsScreen({super.key});

  @override
  State<ScanInstructionsScreen> createState() =>
      _ScanInstructionsScreenState();
}

class _ScanInstructionsScreenState
    extends State<ScanInstructionsScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  bool _isProcessing = false;
  bool _showExtracted = false;

  String? _selectedFileName;
  String? _selectedSource;

  // =============================================================
  // CAMERA
  // =============================================================

  Future<void> _captureWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (image == null) {
        return;
      }

      setState(() {
        _selectedImage = File(image.path);
        _selectedFileName = 'Captured prescription';
        _selectedSource = 'Camera';
        _showExtracted = false;
      });
    } catch (e) {
      _showMessage(
        'Unable to open the camera. Please check camera permission.',
      );
    }
  }

  // =============================================================
  // GALLERY
  // =============================================================

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );

      if (image == null) {
        return;
      }

      setState(() {
        _selectedImage = File(image.path);
        _selectedFileName = 'Selected prescription';
        _selectedSource = 'Gallery';
        _showExtracted = false;
      });
    } catch (e) {
      _showMessage(
        'Unable to access your gallery.',
      );
    }
  }

  // =============================================================
  // PDF
  // =============================================================

  Future<void> _pickPdf() async {
    // Prototype placeholder.
    //
    // Real PDF picker can be connected later using
    // file_picker or another document picker.

    _showMessage(
      'PDF upload will be connected in the next version.',
    );
  }

  // =============================================================
  // PROCESS WITH AI
  // =============================================================

  Future<void> _understandWithAI() async {
    if (_selectedImage == null) {
      _showMessage(
        'Please capture or select your instructions first.',
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _showExtracted = false;
    });

    // Prototype AI/OCR processing simulation.
    //
    // Later this will be replaced by:
    // Camera/Image → OCR → Medical text extraction →
    // AI interpretation → Care tasks.

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isProcessing = false;
      _showExtracted = true;
    });
  }

  // =============================================================
  // REMOVE SELECTED DOCUMENT
  // =============================================================

  void _removeDocument() {
    setState(() {
      _selectedImage = null;
      _selectedFileName = null;
      _selectedSource = null;
      _showExtracted = false;
      _isProcessing = false;
    });
  }

  // =============================================================
  // MESSAGE
  // =============================================================

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =============================================================
  // CONTINUE TO CARE PLAN
  // =============================================================

  void _continueToCarePlan() {
    _showMessage(
      'Care Plan will be connected next.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppTheme.navy,
            size: 20,
          ),
        ),
        title: const Text(
          'Scan Instructions',
          style: TextStyle(
            color: AppTheme.navy,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // INTRODUCTION
              // =================================================

              _buildHeader(),

              const SizedBox(height: 22),

              // =================================================
              // DOCUMENT SELECTION
              // =================================================

              if (_selectedImage == null)
                _buildSelectionCard()
              else
                _buildDocumentPreview(),

              const SizedBox(height: 20),

              // =================================================
              // PROCESSING
              // =================================================

              if (_isProcessing)
                _buildProcessingCard(),

              // =================================================
              // EXTRACTED INFORMATION
              // =================================================

              if (_showExtracted && !_isProcessing)
                _buildExtractedInformation(),

              const SizedBox(height: 22),

              // =================================================
              // PRIVACY NOTE
              // =================================================

              _buildPrivacyCard(),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // HEADER
  // =============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE5F9F7),
            Color(0xFFDDF4F3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.document_scanner_rounded,
              color: AppTheme.primary,
              size: 29,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make your instructions simple',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Take a clear photo of your prescription, '
                      'discharge summary, or care instructions. '
                      'CareBridge will turn them into simple care tasks.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
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

  // =============================================================
  // SELECTION CARD
  // =============================================================

  Widget _buildSelectionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add your instructions',
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Choose how you want to provide your document.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12.5,
            ),
          ),

          const SizedBox(height: 18),

          // -----------------------------------------------------
          // CAMERA
          // -----------------------------------------------------

          _DocumentOption(
            icon: Icons.camera_alt_rounded,
            title: 'Scan with Camera',
            subtitle:
            'Take a clear photo using your phone camera',
            color: AppTheme.primary,
            onTap: _captureWithCamera,
            primary: true,
          ),

          const SizedBox(height: 11),

          // -----------------------------------------------------
          // GALLERY
          // -----------------------------------------------------

          _DocumentOption(
            icon: Icons.photo_library_outlined,
            title: 'Choose from Gallery',
            subtitle:
            'Select an existing photo from your phone',
            color: const Color(0xFF2D8CFF),
            onTap: _pickFromGallery,
          ),

          const SizedBox(height: 11),

          // -----------------------------------------------------
          // PDF
          // -----------------------------------------------------

          _DocumentOption(
            icon: Icons.picture_as_pdf_outlined,
            title: 'Upload PDF',
            subtitle:
            'Use a digital prescription or discharge document',
            color: const Color(0xFFE36B5D),
            onTap: _pickPdf,
          ),

          const SizedBox(height: 18),

          // -----------------------------------------------------
          // TIP
          // -----------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8F8),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xFFD18A19),
                  size: 20,
                ),
                SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Tip: Place the document on a flat surface '
                        'and make sure all text is visible and well lit.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
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
  // DOCUMENT PREVIEW
  // =============================================================

  Widget _buildDocumentPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Document captured',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              IconButton(
                onPressed: _removeDocument,
                tooltip: 'Remove',
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF2E9B68),
                size: 17,
              ),

              const SizedBox(width: 6),

              Text(
                _selectedSource ?? 'Document',
                style: const TextStyle(
                  color: Color(0xFF2E9B68),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // -----------------------------------------------------
          // IMAGE
          // -----------------------------------------------------

          if (_selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  maxHeight: 380,
                ),
                color: const Color(0xFFF3F5F5),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          const SizedBox(height: 14),

          // -----------------------------------------------------
          // FILE NAME
          // -----------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F9F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: AppTheme.primary,
                  size: 20,
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    _selectedFileName ??
                        'Selected document',
                    style: const TextStyle(
                      color: AppTheme.navy,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // -----------------------------------------------------
          // UNDERSTAND WITH AI BUTTON
          // -----------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed:
              _isProcessing ? null : _understandWithAI,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                AppTheme.primary.withValues(
                  alpha: 0.5,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 21,
                  ),
                  SizedBox(width: 9),
                  Text(
                    'Understand with AI',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: _isProcessing
                  ? null
                  : _captureWithCamera,
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 18,
              ),
              label: const Text(
                'Retake photo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // PROCESSING CARD
  // =============================================================

  Widget _buildProcessingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F7F5),
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(22),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppTheme.primary,
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Understanding your instructions...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.navy,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'CareBridge is reading the document and '
                'organizing important care information.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 20),

          _ProcessingStep(
            icon: Icons.document_scanner_outlined,
            text: 'Reading document',
            completed: true,
          ),

          const SizedBox(height: 9),

          _ProcessingStep(
            icon: Icons.text_fields_rounded,
            text: 'Extracting information',
            completed: true,
          ),

          const SizedBox(height: 9),

          _ProcessingStep(
            icon: Icons.auto_awesome_rounded,
            text: 'Creating simple care tasks',
            completed: false,
          ),
        ],
      ),
    );
  }

  // =============================================================
  // EXTRACTED INFORMATION
  // =============================================================

  Widget _buildExtractedInformation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFD8EFE9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------------------
          // SUCCESS
          // -----------------------------------------------------

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F7EE),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF2E9B68),
                  size: 25,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions understood',
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'We found the following care information.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // -----------------------------------------------------
          // MEDICATION
          // -----------------------------------------------------

          _ExtractedItem(
            icon: Icons.medication_outlined,
            title: 'Medication',
            value: 'Paracetamol 500 mg',
            detail: 'Take 1 tablet after food',
            color: AppTheme.primary,
          ),

          const SizedBox(height: 11),

          // -----------------------------------------------------
          // TIMING
          // -----------------------------------------------------

          _ExtractedItem(
            icon: Icons.schedule_rounded,
            title: 'Schedule',
            value: 'Twice a day',
            detail: 'After breakfast and after dinner',
            color: const Color(0xFF2D8CFF),
          ),

          const SizedBox(height: 11),

          // -----------------------------------------------------
          // FOLLOW UP
          // -----------------------------------------------------

          _ExtractedItem(
            icon: Icons.calendar_month_outlined,
            title: 'Follow-up',
            value: 'Doctor appointment',
            detail: 'In 7 days',
            color: const Color(0xFF8B5FBF),
          ),

          const SizedBox(height: 18),

          // -----------------------------------------------------
          // AI DISCLAIMER
          // -----------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8ED),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFFD18A19),
                  size: 19,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'CareBridge simplifies your instructions. '
                        'Always follow the original instructions '
                        'provided by your healthcare professional.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 10.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // -----------------------------------------------------
          // CONTINUE
          // -----------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _continueToCarePlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(17),
                ),
              ),
              child: const Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    'Create My Care Plan',
                    style: TextStyle(
                      fontSize: 15,
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
    );
  }

  // =============================================================
  // PRIVACY
  // =============================================================

  Widget _buildPrivacyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7F0),
        borderRadius: BorderRadius.circular(19),
      ),
      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            color: Color(0xFF2E9B68),
            size: 20,
          ),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              'Your documents contain sensitive health information. '
                  'CareBridge is designed to keep your information private.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 10.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// DOCUMENT OPTION
// ===============================================================

class _DocumentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final bool primary;

  const _DocumentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: primary
                ? color.withValues(alpha: 0.08)
                : const Color(0xFFF8FAFA),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: primary
                  ? color.withValues(alpha: 0.35)
                  : const Color(0xFFE5EBEB),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.navy,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// PROCESSING STEP
// ===============================================================

class _ProcessingStep extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool completed;

  const _ProcessingStep({
    required this.icon,
    required this.text,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 31,
          height: 31,
          decoration: BoxDecoration(
            color: completed
                ? const Color(0xFFE7F7EE)
                : const Color(0xFFE8F7F5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            completed
                ? Icons.check_rounded
                : icon,
            color: completed
                ? const Color(0xFF2E9B68)
                : AppTheme.primary,
            size: 17,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          text,
          style: const TextStyle(
            color: AppTheme.navy,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ===============================================================
// EXTRACTED ITEM
// ===============================================================

class _ExtractedItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String detail;
  final Color color;

  const _ExtractedItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.12,
              ),
              borderRadius:
              BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
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
                    color: AppTheme.textSecondary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  detail,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    height: 1.3,
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