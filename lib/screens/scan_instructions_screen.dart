import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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

  XFile? _selectedImage;
  PlatformFile? _selectedPdf;
  bool _isProcessing = false;

  // =============================================================
  // CAMERA
  // =============================================================

  Future<void> _openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
          _selectedPdf = null;
        });
      }
    } catch (e) {
      _showMessage('Unable to open camera.');
    }
  }

  // =============================================================
  // GALLERY
  // =============================================================

  Future<void> _openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
          _selectedPdf = null;
        });
      }
    } catch (e) {
      _showMessage('Unable to open gallery.');
    }
  }

  // =============================================================
  // PDF PICKER
  // =============================================================

  Future<void> _openPdfPicker() async {
    try {
      final FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: kIsWeb,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      setState(() {
        _selectedPdf = result.files.first;
        _selectedImage = null;
      });
    } catch (e) {
      _showMessage('Unable to select PDF.');
    }
  }

  // =============================================================
  // REMOVE DOCUMENT
  // =============================================================

  void _removeDocument() {
    setState(() {
      _selectedImage = null;
      _selectedPdf = null;
    });
  }

  // =============================================================
  // PROCESS DOCUMENT
  // =============================================================

  Future<void> _processDocument() async {
    if (_selectedImage == null && _selectedPdf == null) {
      _showMessage('Please select a document first.');
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Temporary prototype processing.
    // This will later be replaced with OCR + AI.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isProcessing = false;
    });

    _showProcessingResult();
  }

  // =============================================================
  // PROCESSING RESULT
  // =============================================================

  void _showProcessingResult() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            30,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE3E3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F7EF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF2E9B68),
                  size: 40,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Document processed',
                style: TextStyle(
                  color: AppTheme.navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'CareBridge has identified important '
                    'care information from your document.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              _InstructionPreview(
                icon: Icons.medication_outlined,
                title: 'Medication',
                subtitle:
                'Take your prescribed medication as instructed.',
              ),

              const SizedBox(height: 10),

              _InstructionPreview(
                icon: Icons.schedule_outlined,
                title: 'Schedule',
                subtitle:
                'Follow the recommended medication schedule.',
              ),

              const SizedBox(height: 10),

              _InstructionPreview(
                icon: Icons.favorite_outline,
                title: 'Follow-up care',
                subtitle:
                'Follow the care instructions provided by your doctor.',
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Continue to Care Plan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.navy,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // HERO
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
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
                  children: [
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
                      child: const Icon(
                        Icons.document_scanner_outlined,
                        color: AppTheme.primary,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Understand your care',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.navy,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Upload your prescription or discharge '
                          'document and CareBridge will help '
                          'simplify the important instructions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // NO DOCUMENT
              // =================================================

              if (_selectedImage == null &&
                  _selectedPdf == null) ...[
                const Text(
                  'Add your document',
                  style: TextStyle(
                    color: AppTheme.navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Choose how you want to add your document.',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 18),

                _ScanOptionCard(
                  icon: Icons.camera_alt_outlined,
                  title: 'Scan with Camera',
                  subtitle:
                  'Take a clear photo of your document',
                  color: const Color(0xFF2D8CFF),
                  onTap: _openCamera,
                ),

                const SizedBox(height: 14),

                _ScanOptionCard(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle:
                  'Select an existing image',
                  color: const Color(0xFF8B5FBF),
                  onTap: _openGallery,
                ),

                const SizedBox(height: 14),

                _ScanOptionCard(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Upload PDF',
                  subtitle:
                  'Select a prescription or discharge PDF',
                  color: const Color(0xFFE05A47),
                  onTap: _openPdfPicker,
                ),
              ],

              // =================================================
              // SELECTED DOCUMENT
              // =================================================

              if (_selectedImage != null ||
                  _selectedPdf != null)
                _buildSelectedDocument(),

              const SizedBox(height: 28),

              // =================================================
              // SUPPORTED FORMATS
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primary,
                      size: 24,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Supported formats',
                            style: TextStyle(
                              color: AppTheme.navy,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'JPG, PNG and PDF files',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // =================================================
              // PRIVACY
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Color(0xFF2E9B68),
                      size: 23,
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Your health information is private. '
                            'Only you and authorized guardians can '
                            'access relevant care information.',
                        style: TextStyle(
                          color: AppTheme.navy,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // SELECTED DOCUMENT
  // =============================================================

  Widget _buildSelectedDocument() {
    final bool isPdf = _selectedPdf != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Document selected',
          style: TextStyle(
            color: AppTheme.navy,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: isPdf
              ? _buildPdfPreview()
              : _buildImagePreview(),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _removeDocument,
                icon: const Icon(Icons.refresh),
                label: const Text('Choose Another'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.navy,
                  side: const BorderSide(
                    color: Color(0xFFD7DEDE),
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    52,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton.icon(
                onPressed:
                _isProcessing ? null : _processDocument,
                icon: _isProcessing
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  _isProcessing
                      ? 'Processing...'
                      : 'Process',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                  AppTheme.primary.withValues(
                    alpha: 0.6,
                  ),
                  minimumSize: const Size(
                    double.infinity,
                    52,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =============================================================
  // IMAGE PREVIEW
  // =============================================================

  Widget _buildImagePreview() {
    if (kIsWeb) {
      return Image.network(
        _selectedImage!.path,
        fit: BoxFit.contain,
        errorBuilder: (
            context,
            error,
            stackTrace,
            ) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: AppTheme.textSecondary,
            ),
          );
        },
      );
    }

    return Image.file(
      File(_selectedImage!.path),
      fit: BoxFit.contain,
      errorBuilder: (
          context,
          error,
          stackTrace,
          ) {
        return const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 50,
            color: AppTheme.textSecondary,
          ),
        );
      },
    );
  }

  // =============================================================
  // PDF PREVIEW
  // =============================================================

  Widget _buildPdfPreview() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECE8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.picture_as_pdf_rounded,
              color: Color(0xFFE05A47),
              size: 50,
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              _selectedPdf?.name ?? 'PDF document',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.navy,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _formatFileSize(
              _selectedPdf?.size ?? 0,
            ),
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

// ===============================================================
// SCAN OPTION CARD
// ===============================================================

class _ScanOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ScanOptionCard({
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
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.navy,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 17,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// INSTRUCTION PREVIEW
// ===============================================================

class _InstructionPreview extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InstructionPreview({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F9F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: AppTheme.primary,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    height: 1.4,
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