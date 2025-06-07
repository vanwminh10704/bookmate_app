import 'login_page.dart';
import 'package:flutter/material.dart';
import '../../models/app_use_model.dart';
import '../../services/shared_prefs.dart';
import '../../components/app_text_field.dart';
import '../../components/app_elevated_button.dart';
import '../../components/app_text_field_password.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  SharedPrefs prefs = SharedPrefs();

  String get validate {
  // Kiểm tra các trường bắt buộc
  if (nameController.text.trim().isEmpty) {
    return 'Vui lòng nhập họ tên';
  }
  if (emailController.text.trim().isEmpty) {
    return 'Vui lòng nhập email';
  }
  if (passwordController.text.isEmpty) {
    return 'Vui lòng nhập mật khẩu';
  }
  if (confirmPasswordController.text.isEmpty) {
    return 'Vui lòng nhập xác nhận mật khẩu';
  }

  // Validate email formatMinh
  String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  String email = emailController.text.trim();
  if (!RegExp(emailPattern).hasMatch(email)) {
    return 'Email không hợp lệ';
  }

  // Validate password
  String password = passwordController.text;
  if (password.length <= 6) {
    return 'Mật khẩu phải có nhiều hơn 6 ký tự';
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return 'Mật khẩu phải chứa ít nhất 1 chữ in hoa';
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return 'Mật khẩu phải chứa ít nhất 1 số';
  }
  
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return 'Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt';
  }
  
  if (password != confirmPasswordController.text) {
    return 'Mật khẩu xác nhận không khớp';
  }

  return 'isValid';
}

  void _submitRegister() async {
    if (validate == 'isValid') {
      AppUserModel user = AppUserModel()
        ..name = nameController.text.trim()
        ..email = emailController.text.trim()
        ..password = passwordController.text;

      await prefs.saveUser(user);

      const snackBar = SnackBar(content: Text('Đăng ký thành công! 🎉'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(email: emailController.text.trim()),
        ),
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
                  'Đăng ký',
                  style: TextStyle(color: Color(0xFFBDC65B), fontSize: 26.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                AppTextField(
                  controller: nameController,
                  prefixIcon: const Icon(Icons.person, color: Color(0xFFBDC65B)),
                  labelText: 'Họ tên',
                  hintText: 'Nhập họ tên',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
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
                  prefixIcon: const Icon(Icons.password, color: Color(0xFFBDC65B)),
                  labelText: 'Mật khẩu',
                  hintText: 'Nhâp mật khẩu',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: confirmPasswordController,
                  prefixIcon: const Icon(Icons.password, color: Color(0xFFBDC65B)),
                  labelText: 'Xác nhận mật khẩu',
                  hintText: 'Nhập lại mật khẩu',
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    _submitRegister();
                  },
                ),
                const SizedBox(height: 60.0),
                AppElevatedButton(
                  onPressed: () {
                    _submitRegister();
                  },
                  text: 'Đăng ký',
                  textColor: Colors.white,
                  color: Color(0xFFBDC65B),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Đã có tài khoản? Đăng nhập",
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
