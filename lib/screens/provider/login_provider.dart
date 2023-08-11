import 'dart:async';

import 'package:ecommerceapp/cubit/user_cubit.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider with ChangeNotifier{
  final BuildContext context;
  LoginProvider(this.context){
    listenToUserCubit();
  }
  bool isLoading = false;
  String error ="";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final Formkey =GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void listenToUserCubit(){

    _userSubscription =BlocProvider.of<UserCubit>(context).stream.listen((userState){
      if(userState is UserLoadingState){
        isLoading =true;
        error ="";
        notifyListeners();
      }else if(userState is UserErrorState){
        isLoading =false;
        error = userState.message;
        notifyListeners();
      }else{
        isLoading =false;
        error ="";
        notifyListeners();
      }
    });
}
  void login()async{
    if(!Formkey.currentState!.validate()) return;
    String email =emailController.text.trim();
    String password =passwordController.text.trim();
    BlocProvider.of<UserCubit>(context).signIn(email: email, password: password);
  }
  // void signUp()async{
  //   String email =emailController.text.trim();
  //   String password =passwordController.text.trim();
  //   String name = nameController.text.trim();
  //   BlocProvider.of<UserCubit>(context).createAccount(email: email, password: password,username: name);
  // }
  @override
  void dispose() {
    _userSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}