import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:sophy/core/di/service_locator.dart';
import 'package:sophy/core/store/auth_store.dart';
import 'package:sophy/features/presentation/widgets/icon_button.dart';

class ProfilePageLaptop extends StatefulWidget {
  const ProfilePageLaptop({super.key});

  @override
  State<ProfilePageLaptop> createState() => _ProfilePageLaptopState();
}

class _ProfilePageLaptopState extends State<ProfilePageLaptop> {
  final AuthStore _authStore = getIt<AuthStore>();

  Future<void> _showEditProfileDialog(BuildContext context) async {
    final nameController = TextEditingController(text: _authStore.userName);
    final avatarController = TextEditingController(text: _authStore.userAvatar);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: avatarController,
                decoration: const InputDecoration(labelText: 'Avatar URL'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _authStore.updateProfile(
                  name: nameController.text.trim(),
                  avatarUrl: avatarController.text.trim(),
                );
                if (context.mounted) Navigator.pop(context);
              } catch (e) {
                // Handle error
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: MyIconButton(
              width: 50,
              height: 50,
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.push('/settings');
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(48),
            child: Observer(
              builder: (context) {
                final user = _authStore.user;
                if (user == null) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('You are not logged in.'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Login'),
                      ),
                    ],
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      backgroundImage: _authStore.userAvatar != null
                          ? NetworkImage(_authStore.userAvatar!)
                          : null,
                      child: _authStore.userAvatar == null
                          ? Icon(
                              Icons.person,
                              size: 100,
                              color: theme.colorScheme.onPrimaryContainer,
                            )
                          : null,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      _authStore.userName ?? user.email ?? 'No Name',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.email ?? 'No Email',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () => _showEditProfileDialog(context),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
