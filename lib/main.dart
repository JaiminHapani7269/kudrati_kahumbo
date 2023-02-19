import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudrati_kahumbo/firebase_options.dart';
import 'package:kudrati_kahumbo/provider/cart_provider.dart';
import 'package:kudrati_kahumbo/provider/wishlist_provider.dart';
import 'package:kudrati_kahumbo/screen/about_us_page.dart';
import 'package:kudrati_kahumbo/screen/auth/regisration_screen.dart';
import 'package:kudrati_kahumbo/screen/auth/otp_screen.dart';
import 'package:kudrati_kahumbo/screen/contact_us_page.dart';
import 'package:kudrati_kahumbo/screen/feedback_page.dart';
import 'package:kudrati_kahumbo/screen/home_page.dart';
import 'package:kudrati_kahumbo/screen/my_order_page.dart';
import 'package:kudrati_kahumbo/screen/order_done_page.dart';
import 'package:kudrati_kahumbo/screen/payment_page.dart';
import 'package:kudrati_kahumbo/screen/splash_screen.dart';
import 'package:kudrati_kahumbo/screen/wishlist_page.dart';
import 'package:kudrati_kahumbo/utils/app_colors.dart';
import 'package:kudrati_kahumbo/screen/cart.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //ab.txt
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WishListProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: GetMaterialApp(
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
          'cart': (context) => const CartPage(),
          'wishlist': (context) => const WishListPage(),
          'aboutUs': (context) => const AboutUsPage(),
          'contactUs': (context) => const ContactUsPage(),
          'payment': (context) => const PaymentPage(),
          'orderDone': (context) => const OrderDonePage(),
          'myOrder': (context) => const MyOrderPage(),
          'feedback': (context) => const FeedbackPage(),
        },
      ),
    );
  }
}
