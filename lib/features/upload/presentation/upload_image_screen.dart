import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/image_upload_service.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({
    super.key,
    this.picker,
    this.service,
    this.initialSelectedImage,
    this.disableLocalImagePreview = false,
  });
  final bool disableLocalImagePreview;

  // For widget tests (dependency injection)
  final ImagePicker? picker;
  final ImageUploadService? service;

  // For widget tests (skip real picker)
  final File? initialSelectedImage;

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late final ImagePicker _picker;
  late final ImageUploadService _service;

  File? _selectedImage;
  String? _uploadedImageUrl;
  bool _isUploading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _picker = widget.picker ?? ImagePicker();
    _service = widget.service ?? ImageUploadService();
    _selectedImage = widget.initialSelectedImage;
  }

  Future<void> _pickImage() async {
    setState(() {
      _error = null;
    });

    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() {
      _selectedImage = File(picked.path);
      _uploadedImageUrl = null;
    });
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      setState(() {
        _error = "Please pick an image first.";
      });
      return;
    }

    setState(() {
      _isUploading = true;
      _error = null;
    });

    try {
      final url = await _service.uploadImage(_selectedImage!);
      setState(() {
        _uploadedImageUrl = url;
      });
    } catch (e) {
      setState(() {
        _error = "Upload failed. Please try again.";
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sprint 5: Upload Image")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              key: const Key('pickImageBtn'),
              onPressed: _isUploading ? null : _pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 12),

            if (_selectedImage != null) ...[
              const Text("Selected Image (local):"),
              const SizedBox(height: 8),
              if (!widget.disableLocalImagePreview)
                SizedBox(
                  height: 180,
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                )
              else
                const SizedBox(height: 180),

              const SizedBox(height: 12),
            ],

            ElevatedButton(
              key: const Key('uploadBtn'),
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? const SizedBox(
                      key: Key('uploadLoading'),
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Upload to Server"),
            ),

            const SizedBox(height: 12),

            if (_error != null) ...[
              Text(
                _error!,
                key: const Key('errorText'),
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12),
            ],

            if (_uploadedImageUrl != null) ...[
              const Text("Image from Server:"),
              const SizedBox(height: 8),
              Expanded(
                child: Image.network(
                  _uploadedImageUrl!,
                  key: const Key('serverImage'),
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Text("Failed to load server image"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
