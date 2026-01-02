import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:sophy/features/music/presentation/store/music_store.dart';
import 'package:sophy/core/theme/colors.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  final MusicStore _musicStore = getIt<MusicStore>();
  final AuthStore _authStore = getIt<AuthStore>();
  final TextEditingController _trackNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();

  File? _imageFile;
  File? _songFile;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickSong() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _songFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _upload() async {
    if (!_authStore.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to upload tracks')),
      );
      return;
    }
    
    if (_trackNameController.text.isEmpty ||
        _artistNameController.text.isEmpty ||
        _imageFile == null ||
        _songFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and pick files')),
      );
      return;
    }

    try {
      await _musicStore.uploadTrack(
        name: _trackNameController.text,
        artist: _artistNameController.text,
        imageFile: _imageFile!,
        songFile: _songFile!,
        category: 'Pop', // Default category for now
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Track uploaded successfully!')),
        );
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Author Studio')),
      body: Observer(
        builder: (context) {
          if (_musicStore.isUploading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Upload New Track',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _trackNameController,
                  decoration: const InputDecoration(
                    labelText: 'Track Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.music_note),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _artistNameController,
                  decoration: const InputDecoration(
                    labelText: 'Artist Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 24),
                _buildFilePicker(
                  label: 'Cover Image',
                  file: _imageFile,
                  icon: Icons.image,
                  onPick: _pickImage,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildFilePicker(
                  label: 'Song File',
                  file: _songFile,
                  icon: Icons.audio_file,
                  onPick: _pickSong,
                  theme: theme,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _upload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Upload Track',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilePicker({
    required String label,
    required File? file,
    required IconData icon,
    required VoidCallback onPick,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label),
        subtitle: Text(
          file != null ? file.path.split('\\').last : 'No file selected',
        ),
        trailing: TextButton(onPressed: onPick, child: const Text('Pick')),
      ),
    );
  }
}
