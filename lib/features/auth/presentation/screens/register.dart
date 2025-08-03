import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:meal_app/core/Dialogs/dialogs.dart';
import 'package:meal_app/core/Utils/app_colors.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_states.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:meal_app/features/auth/presentation/widgets/custom_field.dart';
import 'package:quickalert/quickalert.dart';

class Register extends StatefulWidget {
   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final nameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   var formKey=GlobalKey<FormState>();
   bool _agreeTerms = false;
   @override
   void dispose() {
     emailController.dispose();
     passwordController.dispose();
     nameController.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    final w=MediaQuery.of(context).size.width;
    return BlocConsumer<AuthBloc,AuthStates>(
      listener: (context, state) {
        if(state is AuthLoading){
         DialogFunctions.showLoadingDialog(context, "Loading..");
        }
        if(state is AuthFailure){
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
              context: context,
              message: state.message,
            posActionName: "Ok",
            title: "Register Fail"
          );
        }
        if(state is AuthSuccess){
          DialogFunctions.hideLoading(context);
          DialogFunctions.showMessageDialog(
              context: context,
              message: "success",
              posActionName: "Ok",
              title: "Register success"
          );
        }
      },
      builder:(context, state) => Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/background.png"),fit:BoxFit.cover)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white,width: 3),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(25),
                      child: Image.asset("assets/app_logo.png"),
                    ),
                    SizedBox(height: 80,),
                    CustomField(
                      keyboardType: TextInputType.text,
                      hint: "Full Name",
                      prefixIcon: Icon(Icons.person,color: AppColors.white,),
                      controller: nameController,
                      obscureText: false,
                      validator: (p0) {
                        if(nameController.text.isEmpty){
                          return  "please enter your name";
                        }
                        return null;
                      },
                    ),
                    Gap(20),
                    CustomField(
                      keyboardType: TextInputType.emailAddress,
                      hint: "Email",
                      prefixIcon: Icon(Icons.email,color: AppColors.white,),
                      controller: emailController,
                      obscureText: false,
                      validator: (p0) {
                        if(emailController.text.isEmpty){
                          return  "please enter your email";
                        }
                        return null;
                      },
                    ),
                    Gap(20),
                    CustomField(
                      keyboardType: TextInputType.number,
                      hint: "Password",
                      prefixIcon: Icon(Icons.lock_outline,color: AppColors.white,),
                      controller: passwordController,
                      obscureText: true,
                      validator: (p0) {
                        if(passwordController.text.isEmpty){
                          return  "please enter your password";
                        }
                        return null;
                      },
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeTerms = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.indigo,
                        ),
                        const Expanded(
                          child: Text(
                            "By creating an account you agree to terms and conditions.",
                            style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    CustomButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(
                              AuthSignUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text)
                            );
                          }
                        },
                        child: Text("Register",style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)
                    ),
                    Gap(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Container(
                          height: 2,
                          width: w*0.28,
                          color: Colors.white,
                        ),
                        Text("or login with",style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                        Container(
                          height: 2,
                          width: w*0.28,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Gap(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("assets/facebook.png"))
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("assets/google.png"))
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                    TextButton(
                        onPressed: (){},
                        child: Text("Do you have account? Login",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),)
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ) ,
    );
  }
}
