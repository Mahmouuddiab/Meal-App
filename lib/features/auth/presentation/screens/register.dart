import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_app/core/Dialogs/dialogs.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/strings.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_states.dart';
import 'package:meal_app/features/auth/presentation/screens/base_auth_screen.dart';
import 'package:meal_app/features/auth/presentation/screens/login_screen.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
            title: "Register Fail",
          );
        }
        if (state is AuthSuccess) {
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: "success",
            posActionName: "Ok",
            title: "Register success",
          );
        }
      },
      builder: (context, state) {
        return BaseAuthScreen(
          formFields: [
            CustomField(
              keyboardType: TextInputType.text,
              hint: AppStrings.fullName,
              label: AppStrings.fullName,
              prefixIcon: const Icon(
                Icons.person_outline,
                color: AppColors.white,
              ),
              controller: nameController,
              validator:
                  (value) =>
                      value?.isEmpty ?? true
                          ? AppStrings.fullNameValidate
                          : null,
            ),
            Gap(15.h),
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
                  (value) =>
                      value?.isEmpty ?? true ? AppStrings.emailValidate : null,
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
                  (value) =>
                      value?.isEmpty ?? true
                          ? AppStrings.passwordValidate
                          : null,
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
            Gap(10.h),
          ],
          buttonText: AppStrings.register,
          onButtonPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthBloc>().add(
                AuthSignUp(
                  email: emailController.text,
                  password: passwordController.text,
                  name: nameController.text,
                ),
              );
            }
          },
          bottomText: AppStrings.haveAccount,
          onBottomTextPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
          checkText: AppStrings.termsAndConditions,
        );
      },
    );
  }
}
