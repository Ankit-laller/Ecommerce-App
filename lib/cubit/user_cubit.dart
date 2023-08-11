import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/data/models/user_model.dart';
import 'package:ecommerceapp/data/repository/user_repositroy.dart';
import 'package:ecommerceapp/logic/services/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit(): super(UserInitState()){
    initialize();
  }
  final UserRepository _userRepository = UserRepository();

  void initialize()async{
    final userDetails = await Preferences.fetchUserDetail();
    String? email = userDetails["email"];
    String? password = userDetails["password"];
    if(email ==null || password== null){
      emit(UserLoggedOutState());
    }else{
      signIn(password: password, email: email);
    }
  }

  void signIn({
    required String password,
    required String email,
})async{
    emit(UserLoadingState());
    try{
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      await Preferences.saveUserpreferences(email, password);
      emit(UserLoggedInState(userModel));
    }catch(err){
      emit(UserErrorState(err.toString()));
    }
  }


  void createAccount({
    required String email,
    required String password,
    required String username,
  })async{
    emit(UserLoadingState());
    try{
      UserModel userModel = await _userRepository.createAccount(email: email,
          password: password, username:username);
      await Preferences.saveUserpreferences(email, password);
      emit(UserLoggedInState(userModel));
    }catch(err){
      emit(UserErrorState(err.toString()));
    }
  }
  void signOut()async{
    await Preferences.clear();
    emit(UserLoggedOutState());
  }
}