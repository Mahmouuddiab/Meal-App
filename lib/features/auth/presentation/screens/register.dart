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

import '../../../../core/Widgets/custom_field.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
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
        else if (state is AuthFailure) {
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: state.message,
            posActionName: "Ok",
            title: "Register Fail",
            posAction: (){
              Navigator.of(context).pop();
            },
          );
        }
        else if (state is AuthSuccess) {
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: "success",
            posActionName: "Ok",
            posAction: (){
              Navigator.of(context).pop();
            },
            title: "Register success",
          );
        }
      },
      builder:
          (context, state) => BaseAuthScreen(
            formKey: formKey,
            formFields: [
              CustomField(
                keyboardType: TextInputType.text,
                hint: AppStrings.fullName,
                style: TextStyle(color: AppColors.white),
                prefixIcon: Icon(Icons.person_outline, color: AppColors.white),
                label: AppStrings.fullName,
                controller: nameController,
                validator:
                    (_) =>
                        AppValidators.displayNamevalidator(nameController.text),
              ),
              Gap(15.h),
              CustomField(
                keyboardType: TextInputType.emailAddress,
                hint: AppStrings.email,
                label: AppStrings.email,
                style: TextStyle(color: AppColors.white),
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
                style: TextStyle(color: AppColors.white),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.white,
                ),
                controller: passwordController,
                obscureText: obscureText,
                validator:
                    (_) => AppValidators.passwordValidator(
                      passwordController.text,
                    ),
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
              Gap(15.h),
              CustomField(
                keyboardType: TextInputType.phone,
                hint: AppStrings.phone,
                style: TextStyle(color: AppColors.white),
                prefixIcon: Icon(Icons.phone, color: AppColors.white),
                label: AppStrings.phone,
                controller: phoneController,
                validator:
                    (_) =>
                        AppValidators.phoneValidator(phoneController.text),
              ),
            ],
            buttonText: AppStrings.register,
            onButtonPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  AuthSignUp(
                    email: emailController.text,
                    password: passwordController.text,
                    phone: phoneController.text,
                    name: nameController.text
                  ),
                );
              }
            },
            bottomText: AppStrings.haveAccount,
            onBottomTextPressed:
                () => Navigator.pushNamed(context, AppRoutes.login),
            checkText: AppStrings.termsAndConditions,
          ),
    );
  }
}
