import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/common/primary_button.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';
import 'package:flutter_e_commerce/config/routes.dart';
import 'package:flutter_e_commerce/feature/auth/provider/auth_provider.dart';
import 'package:flutter_e_commerce/feature/shared_widget/custom_password_textfield.dart';
import 'package:flutter_e_commerce/feature/shared_widget/custom_tex.dart';
import 'package:flutter_e_commerce/feature/shared_widget/custom_textfield.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthProvider>().checkAuthStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
            onTap: () {
              context.go('/$home');
            },
            child: SvgPicture.asset('assets/images/b-logo.svg')),
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, _) {
        return Center(
          child: Card(
            color: Colors.white,
            surfaceTintColor: AppColors.white,
            elevation: 6,
            child: SizedBox(
              height: 570,
              width: 1020,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Form section
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                        key: provider.loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              text: 'Sign In',
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Email",
                              validator: (email) {
                                if (email.isEmpty ||
                                    !provider.isValidEmail(email)) {
                                  return 'Please enter a valid email address';
                                }
                              },
                              controller: provider.emailController,
                              prefixIcon: const Icon(Icons.email),
                            ),
                            const SizedBox(height: 16),
                            CustomPasswordField(
                              labelText: "Password",
                              onTap: () => provider.openAndCloseEye(),
                              isOpen: provider.isEyeOpen,
                              controller: provider.passwordController,
                              prefixIcon: const Icon(Icons.lock),
                              validator: (value) =>
                                  provider.isPasswordValid(value),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (_) {}),
                                    const CustomTextWidget(text: 'Remember Me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to Forgot Password page
                                  },
                                  child: const CustomTextWidget(
                                      text: 'Forgot Password'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            PrimaryButton(
                              onTap: () {
                                // Handle login logic
                                provider.onLogin(context);
                              },
                              text: 'Sign In',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Illustration and signup section
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.6),
                                AppColors.primary.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Welcome to login',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: () {
                                context.go("/$register");
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
