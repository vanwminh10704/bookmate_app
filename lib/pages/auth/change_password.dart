import 'package:flutter/material.dart';
import '../../models/app_use_model.dart';
import '../../services/shared_prefs.dart';
import '../../components/app_elevated_button.dart';
import '../../components/app_text_field_password.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController? oldPasswordController;
  TextEditingController? newPasswordController;
  TextEditingController? confirmPasswordController;

  SharedPrefs? sharedPrefs;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    sharedPrefs = SharedPrefs();
  }

  @override
  void dispose() {
    oldPasswordController?.dispose();
    newPasswordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _changePassword() async {
    if (oldPasswordController == null ||
        newPasswordController == null ||
        confirmPasswordController == null ||
        sharedPrefs == null) {
      _showMessage("Lỗi hệ thống!");
      return;
    }

    String oldPassword = oldPasswordController!.text.trim();
    String newPassword = newPasswordController!.text.trim();
    String confirmPassword = confirmPasswordController!.text.trim();

    AppUserModel? user = await sharedPrefs!.getUser();

    if (user == null) {
      _showMessage("Không tìm thấy người dùng!");
      return;
    }

    if (newPassword.isEmpty || confirmPassword.isEmpty || oldPassword.isEmpty) {
      _showMessage("❌ Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    if (oldPassword != user.password) {
      _showMessage("❌ Mật khẩu cũ không đúng!");
      return;
    }

    if (newPassword == oldPassword) {
      _showMessage("❌ Mật khẩu mới không được trùng với mật khẩu cũ!");
      return;
    }

    if (newPassword.length <= 6) {
      _showMessage('Mật khẩu phải có nhiều hơn 6 ký tự');
      return;
    }
    if (!RegExp(r'[A-Z]').hasMatch(newPassword)) {
      _showMessage('Mật khẩu phải chứa ít nhất 1 chữ in hoa');
      return;
    }
    if (!RegExp(r'[0-9]').hasMatch(newPassword)) {
      _showMessage('Mật khẩu phải chứa ít nhất 1 số');
      return;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPassword)) {
      _showMessage('Mật khẩu phải chứa ít nhất 1 ký tự đặc biệt');
      return;
    }

    if (newPassword != confirmPasswordController) {
      _showMessage("❌ Mật khẩu xác nhận không khớp!");
      return;
  }

    user.password = newPassword;
    await sharedPrefs!.saveUser(user);
    _showMessage("✅ Đổi mật khẩu thành công!");
    Navigator.pop(context); // Quay lại màn hình trước
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đổi Mật Khẩu'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                top: MediaQuery.of(context).padding.top + 40.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Đổi Mật Khẩu',
                  style: TextStyle(color: Color(0xFFBDC65B), fontSize: 26.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: oldPasswordController,
                  prefixIcon: const Icon(Icons.email, color: Color(0xFFBDC65B)),
                  labelText: 'Mật khẩu cũ',
                  hintText: 'Nhập mật khẩu cũ',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: newPasswordController,
                  prefixIcon:
                      const Icon(Icons.password, color: Color(0xFFBDC65B)),
                  labelText: 'Mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                AppTextFieldPassword(
                  controller: confirmPasswordController,
                  prefixIcon:
                      const Icon(Icons.password, color: Color(0xFFBDC65B)),
                  labelText: 'Xác nhận mật khẩu',
                  hintText: 'Nhập lại mật khẩu mới',
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    _changePassword();
                  },
                ),
                const SizedBox(height: 60.0),
                AppElevatedButton(
                  onPressed: _changePassword,
                  text: 'Đổi mật khẩu',
                  textColor: Colors.white,
                  color: Color(0xFFBDC65B),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
