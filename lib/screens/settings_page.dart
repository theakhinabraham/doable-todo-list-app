import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:doable_todo_list_app/data/task_dao.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const _prefsKeyNotifications = 'notifications_enabled';

  bool _notificationsEnabled = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_prefsKeyNotifications) ?? false;
    setState(() {
      _notificationsEnabled = enabled;
      _loading = false;
    });
  }

  Future<void> _setNotifications(bool value) async {
    // Ask permission when enabling; if denied, keep it disabled.
    if (value) {
      final granted = await _requestNotificationPermission();
      if (!mounted) return;
      if (!granted) {
        // Inform user and keep toggle off
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification permission denied')),
        );
        value = false;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKeyNotifications, value);
    if (!mounted) return;
    setState(() => _notificationsEnabled = value);
  }

  // Minimal notification permission flow:
  // - iOS 10+ requires user authorization.
  // - Android 13+ requires POST_NOTIFICATIONS permission.
  // This stub uses platform heuristics. For full scheduling, integrate a local
  // notifications plugin later and call its requestPermission APIs.
  Future<bool> _requestNotificationPermission() async {
    // On iOS, show a simple rationale; on Android 13+, users may also need to grant it.
    // For this lightweight example, show a dialog explaining the request.
    final allow = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Allow notifications?'),
        content: Text(
          Platform.isIOS
              ? 'This app would like to send notifications (reminders for tasks).'
              : 'This app would like to post notifications (reminders for tasks).',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Not now')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Allow')),
        ],
      ),
    );
    return allow == true;
  }

  Future<void> _confirmAndClearAll() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all data?'),
        content: const Text('This will delete all tasks and reset the app to a fresh state. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // Wipe the tasks table
    await TaskDao.clearAll();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All data cleared')),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  EdgeInsets get _screenHPad {
    final w = MediaQuery.of(context).size.width;
    final hpad = (w * 0.05).clamp(16.0, 24.0);
    return EdgeInsets.symmetric(horizontal: hpad);
  }

  @override
  Widget build(BuildContext context) {
    final version = '1.0.0';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          tooltip: 'Back',
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          padding: _screenHPad.add(const EdgeInsets.only(bottom: 24, top: 8)),
          children: [
            // Notifications toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
            const SizedBox(height: 24),

            // Clear All Data pill button
            SizedBox(
              height: 48,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: blackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                onPressed: _confirmAndClearAll,
                child: const Text('Clear All Data'),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(height: 1),

            // About section
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'License',
                    style: TextStyle(fontSize: 14, color: descriptionColor, fontWeight: FontWeight.w600),
                  ),
                ),
                Text('MIT', style: TextStyle(fontSize: 14, color: descriptionColor, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Version',
                    style: TextStyle(fontSize: 14, color: descriptionColor, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(version, style: TextStyle(fontSize: 14, color: descriptionColor, fontWeight: FontWeight.w700)),
              ],
            ),

            // Spacer
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),

            // Centered logo + version
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/trans_logo.svg', height: 56),
                const SizedBox(height: 8),
                Text(
                  'Version $version',
                  style: TextStyle(fontSize: 12, color: descriptionColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 32),

                // Social buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIconButton(
                      asset: 'assets/twitter.svg',
                      tooltip: 'X',
                      onTap: () => _openUrl('https://x.com/AkhinAbr'),
                    ),
                    const SizedBox(width: 16),
                    _SocialIconButton(
                      asset: 'assets/github.svg',
                      tooltip: 'GitHub',
                      onTap: () => _openUrl('https://github.com/theakhinabraham'),
                    ),
                    const SizedBox(width: 16),
                    _SocialIconButton(
                      asset: 'assets/linkedin.svg',
                      tooltip: 'LinkedIn',
                      onTap: () => _openUrl('https://www.linkedin.com/in/theakhinabraham'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    required this.asset,
    required this.onTap,
    required this.tooltip,
  });

  final String asset;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 28,
      customBorder: const CircleBorder(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.04),
        ),
        alignment: Alignment.center,
        child: Tooltip(
          message: tooltip,
          child: SvgPicture.asset(
            asset,
            height: 32,
            width: 32,
            //colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}