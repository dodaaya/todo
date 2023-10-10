import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/HOUSE/homeScreen.dart';
import 'package:todo/HOUSE/taskslist/edit_task.dart';
import 'package:todo/authentication/login/login_screen.dart';
import 'package:todo/authentication/register/register_screen.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/app_config_provider.dart';
import 'package:todo/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseFirestore.instance.settings =
  //  Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
//  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppConfigProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RegisterScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        editTask.routeName: (context) => editTask(),
      },
      theme: MyTheme.lightTheme,
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
