import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/theme_extensions.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/services/storage/storage_service.dart';
import '../../../../core/utils/snackbar_utils.dart';

class ReportComplaintPage extends StatefulWidget {
  const ReportComplaintPage({super.key});

  @override
  State<ReportComplaintPage> createState() => _ReportComplaintPageState();
}

class _ReportComplaintPageState extends State<ReportComplaintPage> {
  bool _isOpenComplaint = true;
  String _selectedCategory = 'Facilities';
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  static const String _serverBaseUrl = 'http://10.0.2.2:3000';

    final List<Map<String, dynamic>> _categories = [
    {'name': 'Academics', 'icon': Icons.school_rounded},
    {'name': 'Facilities', 'icon': Icons.apartment_rounded},
    {'name': 'Hostel', 'icon': Icons.hotel_rounded},
    {'name': 'Transport', 'icon': Icons.directions_bus_rounded},
    {'name': 'Finance', 'icon': Icons.payments_rounded},
    {'name': 'Administration', 'icon': Icons.admin_panel_settings_rounded},
    {'name': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() {
      _selectedImage = File(picked.path);
      _isUploading = true;
      _uploadedImageUrl = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);
      final token = storage.getAuthToken();

      final formData = FormData.fromMap({
        'itemPhoto': await MultipartFile.fromFile(
          picked.path,
          filename: picked.name,
        ),
      });

      final response = await ApiClient.dio.post(
        ApiEndpoints.uploadComplaintPhoto,
        data: formData,
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final uploadedUrl = _extractUploadedUrl(response.data);
      if (!mounted) return;
      setState(() {
        _uploadedImageUrl = uploadedUrl;
        _isUploading = false;
      });
      SnackbarUtils.showSuccess(context, 'Photo uploaded successfully');
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
      });
      final msg = e.response?.data?['message']?.toString() ??
          'Failed to upload photo';
      SnackbarUtils.showError(context, msg);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
      });
      SnackbarUtils.showError(context, 'Failed to upload photo');
    }
  }

  String? _extractUploadedUrl(dynamic data) {
    if (data is Map) {
      final direct = data['fileName'] ??
          data['filename'] ??
          data['path'] ??
          data['url'];
      if (direct is String) {
        return _normalizeImageUrl(direct);
      }
      final payload = data['data'] ?? data['file'];
      if (payload is String) {
        return _normalizeImageUrl(payload);
      }
      if (payload is Map) {
        final nested = payload['fileName'] ??
            payload['filename'] ??
            payload['path'] ??
            payload['url'] ??
            payload['name'];
        if (nested is String) {
          return _normalizeImageUrl(nested);
        }
      }
    }
    return null;
  }

  String _normalizeImageUrl(String value) {
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '$_serverBaseUrl/item_photos/$value';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.backgroundColor // Using theme default,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: AppColors.softShadow,
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Submit Complaint',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Open/Resolved Toggle
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppColors.softShadow,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isOpenComplaint = true;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    gradient: _isOpenComplaint
                                        ? AppColors.openGradient
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off_rounded,
                                        size: 20,
                                        color: _isOpenComplaint
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'New Complaint',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: _isOpenComplaint
                                              ? Colors.white
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isOpenComplaint = false;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    gradient: !_isOpenComplaint
                                        ? AppColors.resolvedGradient
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 20,
                                        color: !_isOpenComplaint
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Follow-up Update',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: !_isOpenComplaint
                                              ? Colors.white
                                              : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Photo/Video Upload Section
                      Text(
                        'Attach Proof',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Add Photo Button
                          GestureDetector(
                            onTap: _isUploading ? null : _pickAndUploadImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _isUploading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: _isOpenComplaint
                                                ? AppColors.openGradient
                                                : AppColors.resolvedGradient,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.add_a_photo_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _isUploading ? 'Uploading...' : 'Add Image',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: context.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (_selectedImage != null || _uploadedImageUrl != null) ...[
                            const SizedBox(width: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: 100,
                                height: 100,
                                color: Colors.white,
                                child: _uploadedImageUrl != null
                                    ? Image.network(
                                        _uploadedImageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          Icons.broken_image_rounded,
                                          color: AppColors.textTertiary,
                                        ),
                                      )
                                    : Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Item Title
                      Text(
                        'Complaint Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppColors.softShadow,
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'e.g., Wi-Fi outage, Hostel issue',
                            hintStyle: TextStyle(color: AppColors.textTertiary),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter complaint title';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Category Selection
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _categories.map((category) {
                          final isSelected = _selectedCategory == category['name'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category['name'];
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? (_isOpenComplaint
                                        ? AppColors.openGradient
                                        : AppColors.resolvedGradient)
                                    : null,
                                color: isSelected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: AppColors.softShadow,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    category['icon'],
                                    size: 18,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    category['name'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // Location
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppColors.softShadow,
                        ),
                        child: TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            hintText: _isOpenComplaint
                                ? 'Where did this issue occur?'
                                : 'Where was it resolved?',
                            hintStyle:
                                TextStyle(color: AppColors.textTertiary),
                            prefixIcon: Icon(
                              Icons.location_on_rounded,
                              color: context.textSecondary,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter location';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Description
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: AppColors.softShadow,
                        ),
                        child: TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText:
                                'Provide additional details about the complaint...',
                            hintStyle: TextStyle(color: AppColors.textTertiary),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Submit Button
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            SnackbarUtils.showSuccess(
                              context,
                              _isOpenComplaint
                                  ? 'Complaint submitted successfully!'
                                  : 'Update submitted successfully!',
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            gradient: _isOpenComplaint
                                ? AppColors.openGradient
                                : AppColors.resolvedGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppColors.buttonShadow,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _isOpenComplaint
                                    ? Icons.campaign_rounded
                                    : Icons.add_task_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _isOpenComplaint ? 'Submit Complaint' : 'Submit Update',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







