import 'package:firebase_core/firebase_core.dart';
import 'package:language_app/controllers/authentication_controller.dart';
import 'package:language_app/controllers/course_controller.dart';
import 'package:language_app/controllers/quizz_controller.dart';
import 'package:language_app/controllers/signin_controller.dart';
import 'package:language_app/controllers/signup_controller.dart';
import 'package:language_app/views/screens/splashscreen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SigninController()),
       ChangeNotifierProvider(create: (context) => SignupController()),
      ChangeNotifierProvider(create: (context) => AuthController()),
      ChangeNotifierProvider(create: (context) => CourseController()),
      ChangeNotifierProvider(create: (context) => QuizzController()),

    ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     //Provider.of<AuthController>(context,listen: false).logout();
   return ScreenUtilInit(
            designSize: const Size(375, 812),
      builder: (_, __) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home:  SplashScreen(),
      ),
    );
  }
}
