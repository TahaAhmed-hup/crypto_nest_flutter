import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../onBoarding/signup_or_signin.dart';
import '../../portfolio/data/portfolio_storage.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF101115),
          elevation: 0,
          title: const Text('Settings', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFF101115),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _tile(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'Edit your profile info',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _switchTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  value: state.notificationsEnabled,
                  onChanged: (v) =>
                      context.read<SettingsCubit>().toggleNotifications(v),
                ),
                const SizedBox(height: 12),
                _switchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  value: state.darkMode,
                  onChanged: (v) =>
                      context.read<SettingsCubit>().toggleDarkMode(v),
                ),
                const SizedBox(height: 12),
                _tile(
                  icon: Icons.security_outlined,
                  title: 'Security',
                  subtitle: 'Password, 2FA',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _tile(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out of the app',
                  onTap: () async {
                    await ProfileStorage.clearUserData();

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const SignupOrSigninPage(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF343640)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF26282F),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF343640)),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
