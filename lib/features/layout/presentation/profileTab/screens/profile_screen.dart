
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_states.dart';
import 'package:meal_app/features/layout/presentation/layout/cubit/layout_cubit.dart';
import 'package:meal_app/features/layout/presentation/profileTab/widgets/edit_user_profile_form.dart';
import '../../../../../core/Dialogs/dialogs.dart';
import '../../../../../core/Utils/app_colors.dart';
import '../../../../../core/Utils/strings.dart';
import '../widgets/input_image.dart';

class ProfileScreen extends StatefulWidget {
 
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final phoneController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late File _selectedImage;

  @override
  void initState(){
    super.initState();
    var currentUser = context.read<LayoutCubit>().currentUser;
    _selectedImage = File(currentUser.imageURL ?? "");
    nameController.text = currentUser.name;
    emailController.text = currentUser.email;
    passwordController.text = currentUser.pass;
    phoneController.text = currentUser.phone;
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context , state){
        if(state is AuthUpdateUserSuccess){
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: "success",
            posActionName: "Ok",
            title: "update success",
          );
         context.read<LayoutCubit>().currentUser = state.user;
        }
        else if(state is AuthUpdateUserFailure){
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
            context: context,
            message: state.message,
            posActionName: "Ok",
            title: "update Fail",
          );
        } 
      },
      builder: (context , state){
          return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputImage(
                        imagePath: _selectedImage.path,
                        onSelectImage: (image) {
                          _selectedImage = image;
                        },
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      EditUserProfileForm(
                        formkey: _formkey,
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        passwordController: passwordController,
                      ),
                    ],
                  ),
                ),
              ),

             ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.primary,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.all(20)
                  )
                ),
                onPressed: (){
                  if(_formkey.currentState!.validate()){
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthUpdateUserData(
                        imageURL: _selectedImage.path ,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text
                      )
                  );
                  }
                }, 
                child: Text(
                  AppStrings.save,
                  style:TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                  ),
                )
              )
            ],
          ),
        );
      },
    );
  }
}
