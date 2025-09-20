import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doable_todo_list_app/services/notification_service.dart';
import 'package:doable_todo_list_app/repositories/task_repository.dart';
import 'package:doable_todo_list_app/screens/add_task_page.dart';
import 'package:doable_todo_list_app/screens/edit_task_page.dart';
import 'package:doable_todo_list_app/screens/home_page.dart';
import 'package:doable_todo_list_app/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Colors
Color blackColor = const Color(0xff0c120c);
Color blueColor = const Color(0xff4285F4);
Color whiteColor = const Color(0xffFDFDFF);
Color iconColor = const Color(0xff565656);
Color outlineColor = const Color(0xffD6D6D6);
Color descriptionColor = const Color(0xff565656);

// TODO: ADD A .env file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is ready

  // Initialize Awesome Notifications
  await AwesomeNotifications().initialize(
    null, // Use default icon
    [
      NotificationChannel(
        channelKey: 'task_reminders',
        channelName: 'Task Reminders',
        channelDescription: 'Notifications for task reminders',
        defaultColor: blueColor,
        ledColor: blueColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );

  // Request notification permissions
  final hasPermission = await NotificationService.requestPermissions();
  if (!hasPermission) {
    print('Notification permission denied');
  } else {
    print('Notification permission granted');
  }

  // Reschedule pending notifications
  try {
    final tasks = await TaskRepository().fetchAll();
    print('Rescheduling ${tasks.length} tasks');
    await NotificationService.rescheduleAllNotifications(tasks);
    print('Notifications rescheduled successfully');
  } catch (e) {
    print('Error rescheduling notifications: $e');
  }

  //status bar & navigation bar colors and themes
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: whiteColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: whiteColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: whiteColor));

  runApp(const DoableApp());
}

class DoableApp extends StatefulWidget {
  const DoableApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<DoableApp> createState() => _DoableAppState();
}

class _DoableAppState extends State<DoableApp> {
  @override
  void initState() {
    super.initState();

    // Set up notification listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    // Handle notification tap
    if (receivedAction.payload?['task_id'] != null) {
      // Navigate to home page to show the task
      DoableApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        'home',
        (route) => false,
      );
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Handle notification created
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Handle notification displayed
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Handle notification dismissed
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: DoableApp.navigatorKey,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //colors
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          //font family
          fontFamily: "Inter",
          textTheme: const TextTheme(
            //Main heading font style - "Create to-do, Modify to-do"
            displayLarge: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Color(0xff0c120c)),
            //Subheading font style - "Today, Settings"
            displayMedium: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff0c120c)),
            //Regular app font style - "Set Reminder, Daily, Save, License, ..."
            displaySmall: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff0c120c)),
            //box heading font style - "Tell us about your task, Date & Time, Completion status, ..."
            labelSmall: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff565656)),
            //Task list heading font style - "Return Library Book"
            bodyLarge: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff0c120c)),
            //Task list description font style - "Gather overdue library books and return..."
            bodyMedium: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff565656)),
            //Task list icon text font style - "11:30 AM, 26/11/24"
            bodySmall: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: Color(0xff565656)),
          )),

      //routes
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'add_task': (context) => const AddTaskPage(),
        'edit_task': (context) => const EditTaskPage(),
        'settings': (context) => const SettingsPage(),
      },
    );
  }
}

double verticalPadding(BuildContext context) {
  return MediaQuery.of(context).size.height / 20;
}

double horizontalPadding(BuildContext context) {
  return MediaQuery.of(context).size.width / 20;
}

EdgeInsets textFieldPadding(BuildContext context) {
  // TODO: Convert 25px into respected MediaQuery size
  return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.1,
      vertical: MediaQuery.of(context).size.height * 0.025);
}

