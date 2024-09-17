import 'package:flutter/cupertino.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/http/cookie_manager.dart';
import 'package:flutter_e_commerce/config/rotues.dart';
import 'package:flutter_e_commerce/feature/shared_widget/toast_message.dart';
import 'package:flutter_e_commerce/service/auth/auth.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: "Eht");
  final emailController = TextEditingController(text: "Eht@ttt.com");
  final passwordController = TextEditingController(text: "123123Ee");
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isEyeOpen = false;
  bool get isEyeOpen => _isEyeOpen;
  Future<void> onRegister(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await AuthService.registerUser(
          nameController.text, emailController.text, passwordController.text);
      CookieManager.insertCookie('accessToken', user.accessToken);
      CookieManager.insertCookie('refreshToken', user.refreshToken);

      CustomToast.showCustomToast(
          message: 'Register Successfully',
          webColor: AppColors.webGreen,
          backgroundColor: AppColors.green,
          textColor: AppColors.white);
      _isLoading = false;
      notifyListeners();
      context.go("$home");
    } catch (e) {
      final message = e.toString().replaceFirst("Exception:", '');
      _isLoading = false;
      notifyListeners();
      CustomToast.showCustomToast(
          message: message,
          webColor: AppColors.webRed,
          backgroundColor: AppColors.red,
          textColor: AppColors.white);
      print("register error $e");
    }
  }

  void openAndCloseEye() {
    _isEyeOpen = !_isEyeOpen;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    // Define a regular expression for a valid email format
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }

  String? isPasswordValid(value) {
    if (value == null || value.toString().length < 8) {
      return 'Password should be more than 8 char';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
