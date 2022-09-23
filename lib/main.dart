import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudrati_kahumbo/firebase_options.dart';
import 'package:kudrati_kahumbo/screen/auth/regisration_screen.dart';
import 'package:kudrati_kahumbo/screen/auth/otp_screen.dart';
import 'package:kudrati_kahumbo/screen/category_product_screen.dart';
import 'package:kudrati_kahumbo/screen/home_page.dart';
import 'package:kudrati_kahumbo/screen/product_detail_screen.dart';
import 'package:kudrati_kahumbo/screen/splash_screen.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kudrati Kahumbo',
      theme: ThemeData(
        primaryColor: AppColors.mainPurple,
        textTheme: GoogleFonts.latoTextTheme(textTheme),
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashScreen(),
        'home': (context) => const HomePage(),
        'registration': (context) => const RegistrationScreen(),
        'otp': (context) => const OTPScreen(),
        'product': (context) => const ProductDerailScreen(),
        'catproduct': (context) => const CategoryProductScreen(),
      },
    );
  }
}
