import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/core/Utils/app_images.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_check_row.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_login_with.dart';
import 'package:meal_app/features/auth/presentation/widgets/social_media_buttons.dart';

class BaseAuthScreen extends StatefulWidget {
  final List<Widget> formFields;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String bottomText;
  final VoidCallback onBottomTextPressed;
  final String checkText;
  final GlobalKey<FormState> formKey;

  const BaseAuthScreen({
    super.key,
    required this.formFields,
    required this.buttonText,
    required this.onButtonPressed,
    required this.bottomText,
    required this.onBottomTextPressed,
    required this.checkText,
    required this.formKey,
  });

  @override
  State<BaseAuthScreen> createState() => _BaseAuthScreenState();
}

class _BaseAuthScreenState extends State<BaseAuthScreen> {
  bool _checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.authBackgroung),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(10.h),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 69.r,
                  child: Image.asset(AppImages.logo),
                ),
                Gap(59.h),
                _buildFormField(),
                Gap(10.h),
                CustomCheckRow(
                  value: _checkValue,
                  onChanged: (value) {
                    setState(() {
                      _checkValue = !_checkValue;
                    });
                  },
                  text: widget.checkText,
                ),
                Gap(12.h),
                CustomButton(
                  onPressed: widget.onButtonPressed,
                  text: widget.buttonText,
                ),
                Gap(24.h),
                const CustomLoginWith(),
                Gap(24.h),
                const SocialButtons(),
                Gap(30.h),
                InkWell(
                  onTap: widget.onBottomTextPressed,
                  child: Text(
                    widget.bottomText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildFormField() =>
      Form(key: widget.formKey, child: Column(children: widget.formFields));
}
