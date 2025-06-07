import 'register_page.dart';
import '../main/main_page.dart';
import 'package:flutter/material.dart';
import '../../models/app_use_model.dart';
import '../../services/shared_prefs.dart';
import '../../components/app_text_field.dart';
import '../../components/app_elevated_button.dart';
import '../../components/app_text_field_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.email});

  final String? email;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedPrefs prefs = SharedPrefs();

  AppUserModel? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email ?? '';
    getUser();
  }

  void getUser() {
    prefs.getUser().then((value) {
      user = value ?? AppUserModel();
      setState(() {});
    });
  }

  String get validate {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (RegExp(emailPattern).hasMatch(email) == false) {
      return 'Email is not valid';
    }

    if ((user?.email != email) || (user?.password != password)) {
      return 'Invalid email or password';
    }

    return 'isValid';
  }

  void _submitLogin() {
    if (validate == 'isValid') {
      prefs.setLogin(true);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      final snackBar = SnackBar(content: Text('$validate 😐'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 40.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Đăng nhập',
                  style: TextStyle(color: Color(0xFFBDC65B), fontSize: 26.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                AppTextField(
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email, color: Color(0xFFBDC65B)),
                  labelText: 'Email',
                  hintText: 'Nhập email',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: passwordController,
                  prefixIcon:
                      const Icon(Icons.password, color: Color(0xFFBDC65B)),
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    _submitLogin();
                  },
                ),
                const SizedBox(height: 60.0),
                AppElevatedButton(
                  onPressed: () {
                    _submitLogin();
                  },
                  text: 'Đăng nhập',
                  textColor: Colors.white,
                  color: Color(0xFFBDC65B),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Chưa có tài khoản? Đăng ký",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
