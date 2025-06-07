import 'dart:async';
import '../auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:book_flutter/pages/main/main_page.dart';
import 'package:book_flutter/services/shared_prefs.dart';
import 'package:book_flutter/pages/onboarding/onboarding_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPrefs prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  void checkStatus() {
    Timer(const Duration(milliseconds: 2000), () async {
      bool isAccess = await prefs.isAccess();
      if (isAccess) {
        bool isLogin = await prefs.isLogin();
        if (isLogin) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  const LoginPage(), // Có thể thêm nút chuyển sang RegisterPage trong LoginPage
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => OnboardingPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Image.asset('assets/images/logo1.png', width: 160.0),
      ),
    );
  }
}
