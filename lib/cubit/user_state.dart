import 'package:ecommerceapp/data/models/user_model.dart';

abstract class UserState{}

class UserInitState extends UserState{

}

class UserLoadingState extends UserState{}

class UserLoggedInState extends UserState{
  final UserModel userModel;
  UserLoggedInState(this.userModel);
}
class UserLoggedOutState extends UserState{}

class UserErrorState extends UserState{
  final String message;
  UserErrorState(this.message);
}

