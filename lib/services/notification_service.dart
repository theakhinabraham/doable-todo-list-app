import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_entity.dart';

class NotificationService {
  static const String channelKey = 'task_reminders';
  static const String _prefsKeyNotifications = 'notifications_enabled';


  static Future<bool> areNotificationsEnabledByUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKeyNotifications) ?? false;
  }

  /// Schedule a notification for a task
  static Future<void> scheduleTaskNotification(TaskEntity task) async {
    // Check if user has enabled notifications
    final userEnabled = await areNotificationsEnabledByUser();
    if (!userEnabled) {
      print('Notification not scheduled: user has disabled notifications');
      return;
    }

    if (!task.hasNotification || task.time == null || task.date == null) {
      print('Notification not scheduled: hasNotification=${task.hasNotification}, time=${task.time}, date=${task.date}');
      return;
    }

    try {
      // Parse the date and time
      final dateFormat = DateFormat('dd/MM/yy');
      final timeFormat = DateFormat('h:mm a');

      final date = dateFormat.parse(task.date!);
      final time = timeFormat.parse(task.time!);

      // Combine date and time
      final scheduledDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      print('Scheduling notification for ${task.title} at $scheduledDateTime');

      // Don't schedule if the time has already passed
      if (scheduledDateTime.isBefore(DateTime.now())) {
        print('Notification not scheduled: time has already passed');
        return;
      }

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: task.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000, // Use timestamp if ID is null
          channelKey: channelKey,
          title: 'Task Reminder',
          body: task.title,
          category: NotificationCategory.Reminder,
          wakeUpScreen: true,
          payload: {
            'task_id': task.id?.toString() ?? '',
            'task_title': task.title,
          },
        ),
        schedule: NotificationCalendar.fromDate(
          date: scheduledDateTime,
          allowWhileIdle: true,
        ),
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  /// Cancel a specific task notification
  static Future<void> cancelTaskNotification(int? taskId) async {
    if (taskId != null) {
      await AwesomeNotifications().cancel(taskId);
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  /// Reschedule all pending task notifications
  static Future<void> rescheduleAllNotifications(List<TaskEntity> tasks) async {
    // Check if user has enabled notifications
    final userEnabled = await areNotificationsEnabledByUser();
    if (!userEnabled) {
      print('Not rescheduling notifications: user has disabled notifications');
      await cancelAllNotifications();
      return;
    }

    // Cancel all existing notifications first
    await cancelAllNotifications();

    // Schedule notifications for all pending tasks
    for (final task in tasks) {
      if (!task.completed && task.hasNotification) {
        await scheduleTaskNotification(task);
      }
    }
  }

  /// Initialize notifications
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      null, // Use default icon
      [
        NotificationChannel(
          channelKey: channelKey,
          channelName: 'Task Reminders',
          channelDescription: 'Reminders for your tasks',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        ),
      ],
    );
  }

  /// Request notification permissions
  static Future<bool> requestPermissions() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      final result = await AwesomeNotifications().requestPermissionToSendNotifications();
      return result;
    }
    return true;
  }

  /// Check if notifications are allowed
  static Future<bool> isNotificationAllowed() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }
}