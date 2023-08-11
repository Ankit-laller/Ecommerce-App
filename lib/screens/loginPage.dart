import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/cubit/user_cubit.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/screens/homepage.dart';
import 'package:ecommerceapp/screens/provider/login_provider.dart';
import 'package:ecommerceapp/screens/signUpPage.dart';
import 'package:ecommerceapp/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName ="Login";
  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: true);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state){
        if(state is UserLoggedInState){
          Navigator.popUntil(context, (route)=> route.isFirst);
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: provider.Formkey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(

                children: [

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text("Log In", style: TextStyles.heading3,),
                    SizedBox(height: 10,),
                    TextFieldInput(
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: provider.emailController,
                      validator: (value){
                        if(value ==null || value.trim().isEmpty){
                          return "Email is required";
                        }
                        if(!EmailValidator.validate(value)){
                          return "Invaild email";
                        }
                        return null;

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: provider.passwordController,
                      isPass: true,
                      validator: (value){
                        if(value ==null || value.trim().isEmpty){
                          return "password is required";
                        }

                        return null;

                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:  EdgeInsets.zero,
                          child: CupertinoButton(child:  const Text("Forgot password?",), onPressed: (){}),
                        )
                      ],
                    ),

                    InkWell(
                      child: Container(
                        height: 40,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          color: AppColors.accent,),
                        child: provider.isLoading ?const Center(child: CircularProgressIndicator(color: Colors.white,),)
                            : const Center(child: Text("Login",) ),
                      ),
                        onTap: () {
                          provider.login();
                        }
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "Don't have an account? ",
                          style: TextStyles.body2,
                        ),
                        CupertinoButton(child: Text("Sign Up"),
                            onPressed: (){
                              Navigator.pushNamed(
                                context,
                                SignUpPage.routeName,
                              );
                            })
                      ],
                    )
                  ]),
                  (provider.error !="")? Text(
                    provider.error,style: const TextStyle(color: Colors.red),
                  ):const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
