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

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
      body: Center(
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
                    child:
                        Consumer<AuthProvider>(builder: (context, provider, _) {
                      return Form(
                        key: provider.registerFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              text: 'Sign Up',
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Name",
                              validator: (name) {
                                if (name.isEmpty ||
                                    name.toString().trim().length < 3) {
                                  return 'Name should be more than 2 letters';
                                }
                              },
                              controller: provider.nameController,
                              prefixIcon: const Icon(Icons.person),
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
                            const SizedBox(height: 24),
                            PrimaryButton(
                              isLoading: provider.isLoading,
                              onTap: () {
                                // Handle sign-up logic
                                if (provider.registerFormKey.currentState!
                                    .validate()) {
                                  provider.onRegister(context);
                                }
                              },
                              text: 'Sign Up',
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                // Illustration and Sign In section
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
                            'Welcome to registration',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {
                              context.go("/$login");
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                            ),
                            child: const Text('Sign In'),
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
      ),
    );
  }
}
