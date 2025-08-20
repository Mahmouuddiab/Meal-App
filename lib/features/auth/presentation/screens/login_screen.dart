import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_app/core/Dialogs/dialogs.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_validators.dart';
import 'package:meal_app/core/Utils/strings.dart';
import 'package:meal_app/core/routing/app_routes.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_states.dart';
import 'package:meal_app/features/auth/presentation/screens/base_auth_screen.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoading) {
          DialogFunctions.showLoadingDialog(context, "Loading..");
        }
        if (state is AuthFailure) {
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: state.message,
            posActionName: "Ok",
            posAction: () {
              Navigator.pop(context);
            },
            title: "Login Fail",
          );
        }
        if (state is AuthSuccess) {
          DialogFunctions.hideLoading(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.layout,
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful"),backgroundColor: Colors.green,duration: Durations.medium3,),
          );
          // DialogFunctions.showMessageDialog(
          //   context: context,
          //   message: "success",
          //   posActionName: "Ok",
          //   posAction: () {
          //     Navigator.pop(context);
          //   },
          //   title: "Login success",
          // );
        }
      },
      builder: (context, state) {
        return BaseAuthScreen(
          formKey: formKey,
          formFields: [
            CustomField(
              keyboardType: TextInputType.emailAddress,
              hint: AppStrings.email,
              label: AppStrings.email,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.white,
              ),
              controller: emailController,
              validator:
                  (_) => AppValidators.emailValidator(emailController.text),
            ),
            Gap(15.h),
            CustomField(
              hint: AppStrings.password,
              label: AppStrings.password,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.white,
              ),
              controller: passwordController,
              obscureText: obscureText,
              validator:
                  (_) =>
                      AppValidators.passwordValidator(passwordController.text),
              suffixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
          buttonText: AppStrings.login,
          onButtonPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthBloc>().add(
                AuthSignIn(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.layout, (route) => false);
            }
          },
          bottomText: AppStrings.doNotHaveAccount,
          onBottomTextPressed:
              () => Navigator.pushNamed(context, AppRoutes.register),
          checkText: AppStrings.rememberMe,
        );
      },
    );
  }
}
