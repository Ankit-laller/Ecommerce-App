import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/data/repository/user_repositroy.dart';
import 'package:ecommerceapp/screens/provider/signUp_provider.dart';
import 'package:ecommerceapp/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
  static const String routeName ="SignUp";
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   bool _isLoading = false;



  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context,listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: provider.Formkey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child:
                Column(children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Sign Up", style: TextStyles.heading3,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextFieldInput(
                    hintText: 'Enter username',
                    textInputType: TextInputType.text,
                    textEditingController: provider.nameController,
                    validator: (value){
                      if(value ==null || value.trim().isEmpty){
                        return "username is required";
                      }

                      return null;

                    },
                  ),

                  const SizedBox(height: 20),
                  TextFieldInput(
                    hintText: 'Enter email',
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
                    hintText: 'Enter password',
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                    hintText: 'Confirm Password',
                    textInputType: TextInputType.text,
                    textEditingController: provider.CpasswordController,
                    isPass: true,
                    validator: (value){
                      if(value != provider.passwordController.text.trim()){
                        return "password is not matched";
                      }

                      return null;

                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent),
                  child: _isLoading? const Center(child: CircularProgressIndicator(color: Colors.white,),) : const Center(child: Text("Sign Up")),
                    ),
                    onTap: () {
                      provider.signUp();

                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                      ),
                      InkWell(
                          child: const Text(
                            " Login",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/Login");
                          }),
                    ],
                  )
                ]),

            ),
        ),
        ),

    );
  }
}
