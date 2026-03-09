import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../features/upload/data/image_upload_service.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  final ImagePicker _picker = ImagePicker();
  final ImageUploadService _uploadService = ImageUploadService();

  String? _profileImageUrl;
  bool _isUploading = false;

  Future<void> _changePhoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    setState(() => _isUploading = true);

    try {
      final url = await _uploadService.uploadImage(File(picked.path));
      setState(() => _profileImageUrl = url);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Upload failed")));
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // real user data from viewmodel
    final user = ref.watch(authViewModelProvider).user;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null
                      ? const Icon(Icons.person, size: 38)
                      : null,
                ),
                InkWell(
                  onTap: _isUploading ? null : _changePhoto,
                  child: CircleAvatar(
                    radius: 16,
                    child: _isUploading
                        ? const SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.camera_alt, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // real user name
            Text(
              user?.name ?? 'Trekly User',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            // real user email
            Text(
              user?.email ?? 'user@trekly.com',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.bookmark_outline),
                    title: const Text("My Bookings"),
                    onTap: () => Navigator.pushNamed(context, '/my-bookings'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text("Change Password"),
                    onTap: () =>
                        Navigator.pushNamed(context, '/change-password'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () {
                      // logout garxa ra login page ma pathauxa
                      ref.read(authViewModelProvider.notifier).logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
