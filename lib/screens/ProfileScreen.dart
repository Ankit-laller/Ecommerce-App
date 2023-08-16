import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/ui.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../data/models/user_model.dart';
import '../widget/linkButton.dart';
import 'edit-profile-screen.dart';
import 'my-orders.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {

          if(state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if(state is UserLoggedInState) {
            return userProfile(state.userModel);
          }

          return const Center(
            child: Text("An error occured!"),
          );

        }
    );
  }
  Widget userProfile(UserModel userModel) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 45),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: Text(
              'My profile',
              textAlign: TextAlign.start,
              style: TextStyles.heading3,
            ),
          ),

          Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),

            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    Stack(
                      // overflow: Overflow.visible,

                      alignment: AlignmentDirectional.topCenter,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),

                        ),
                        const Positioned(
                          top: 0,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            AssetImage('assets/images/user_icon.png',),
                          ),
                        )
                      ],
                    ),
                     Padding(
                       padding: const EdgeInsets.only(top:8.0),
                       child: Text(
                        "${userModel.username}",
                        style:const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                     ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  <Widget>[
                              Text('${userModel.address}',style: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),),
                              Text('${userModel.city}',style: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),),
                              Text('${userModel.state}',style: TextStyles.body2.copyWith(fontWeight: FontWeight.w400),),
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),

          const Divider(),

          ProfileOption(text: "Edit Profile",
          onClick: (){
            Navigator.pushNamed(context, EditProfileScreen.routeName);
          },),
          ProfileOption(text: "My Orders",
          onClick: (){
            Navigator.pushNamed(context, MyOrderScreen.routeName);
          },),
          ProfileOption(text: "Sign Out",
          onClick: (){
            BlocProvider.of<UserCubit>(context).signOut();
          },)


    ])
      );

  }


}


class ProfileOption extends StatelessWidget {
  final VoidCallback? onClick;
  final String text;
  ProfileOption({
    Key? key,
    this.onClick,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
      child: Material(
        elevation: 1,
        child: ListTile(
          // contentPadding: EdgeInsets.all(10),
          title: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onTap: onClick,
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          tileColor: Colors.white,
        ),
      ),
    );
  }
}



