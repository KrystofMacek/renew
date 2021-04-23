import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:renew/common/styling.dart';
import 'package:renew/data/task.dart';
import 'package:renew/screens/interval_settings/interval_settings_screen.dart';
import 'package:renew/screens/main_menu/main_menu_screen.dart';
import 'package:renew/screens/tasks_settings/tasks_settings_screen.dart';
import 'package:renew/screens/timer/timer_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:renew/screens/workout_interval_settings/workout_interval_screen.dart';
import 'package:renew/screens/workout_timer/workout_timer.dart';
import './screens/timer/providers/notifications_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();
  runApp(
    ProviderScope(
      child: RenewApp(
        UniqueKey(),
      ),
    ),
  );
}

_initHive() async {
  Hive.registerAdapter(TaskAdapter());
  await Hive.initFlutter();
  await Hive.openBox('userPreferences');
}

class RenewApp extends StatefulWidget {
  const RenewApp(Key key) : super(key: key);

  @override
  _RenewAppState createState() => _RenewAppState();
}

class _RenewAppState extends State<RenewApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read(notificationProvider).initialize(context);
    // context.read(adsProvider).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final navKey = new GlobalKey<NavigatorState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      theme: getBaseTheme(),
      navigatorKey: navKey,
      routes: {
        '/home': (context) => MainMenuScreen(),
        '/interval': (context) => IntervalSettingsScreen(),
        '/tasks': (context) => TasksSettingsScreen(),
        '/timer': (context) => TimerScreen(),
        '/workout_interval': (context) => WorkoutIntervalSettingsScreen(),
        '/workout_timer': (context) => WorkoutTimerScreen(),
      },
    );
  }
}
