
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


import '../../../../../core/Utils/app_colors.dart';
import '../../../../../core/Utils/app_validators.dart';
import '../../../../../core/Utils/strings.dart';
import '../../../../../core/Widgets/custom_field.dart';


class EditUserProfileForm extends StatefulWidget {

 final TextEditingController  nameController;
 final TextEditingController emailController;
 final TextEditingController passwordController;
 final TextEditingController phoneController;
final GlobalKey<FormState> formkey;

const  EditUserProfileForm({
    required this.formkey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    super.key
  });

  @override
  State<EditUserProfileForm> createState() => _EditUserProfileFormState();
}

class _EditUserProfileFormState extends State<EditUserProfileForm> {

  bool obscureText = true;



  @override
  Widget build(BuildContext context){

    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          CustomField(
              keyboardType: TextInputType.text,
              hint: AppStrings.fullName,
              prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
              label: AppStrings.fullName,
              controller:widget.nameController,
              validator:AppValidators.displayNamevalidator,
            ),
            Gap(22.h),
            CustomField(
              keyboardType: TextInputType.emailAddress,
              hint: AppStrings.email,
              label: AppStrings.email,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.primary,
              ),
              controller: widget.emailController,
              validator:AppValidators.emailValidator,
            ),
            Gap(22.h),
            CustomField(
              hint: AppStrings.password,
              label: AppStrings.password,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: AppColors.primary,
              ),
              controller:widget.passwordController,
              obscureText: obscureText,
              validator: AppValidators.passwordValidator,
              suffixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.primary,
                ),
              ),
            ),
            Gap(22.h),
            CustomField(
              keyboardType: TextInputType.phone,
              hint: AppStrings.phone,
              prefixIcon: Icon(Icons.phone, color: AppColors.primary),
              label: AppStrings.phone,
              controller: widget.phoneController,
              validator: AppValidators.phoneValidator,
            ),
        ],
      ),
    );
  }
}