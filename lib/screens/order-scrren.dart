import 'package:ecommerceapp/cubit/cart/cart_cubit.dart';
import 'package:ecommerceapp/cubit/user_cubit.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/screens/provider/order-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../core/ui.dart';
import '../cubit/cart/cart_state.dart';
import '../cubit/order/order-cubit.dart';
import '../data/models/user_model.dart';
import '../widget/cart-list-items.dart';
import '../widget/linkButton.dart';
import '../widget/widget.dart';
import 'edit-profile-screen.dart';
import 'order-placed-scrren.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName ="OrderScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Order"),
      ),
    body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserState>(
              builder: (context,state){
                if(state is UserLoadingState) {
                  return const CircularProgressIndicator();
                }

                if(state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("User Details", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
                      const GapWidget(),
                      Text("${user.username}", style: TextStyles.heading3),
                      Text("Email: ${user.email}", style: TextStyles.body2,),
                      Text("Phone: ${user.phoneNumber}", style: TextStyles.body2,),
                      Text("Address: ${user.address}, ${user.city}, ${user.state}", style: TextStyles.body2,),
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(context, EditProfileScreen.routeName);
                          },
                          text: "Edit Profile"
                      ),
                    ],
                  );
                }

                if(state is UserErrorState) {
                  return Text(state.message);
                }

                return const SizedBox();
              }),
          const GapWidget(size: 10),

          Text("Items", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
          const GapWidget(),
          BlocBuilder<CartCubit, CartState>(
              builder: (context,state){
                if(state is CartLoadingState && state.items.isEmpty) {
                  return const CircularProgressIndicator();
                }

                if(state is CartErrorState && state.items.isEmpty) {
                  return Text(state.message);
                }

                return CartListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              }),

          const GapWidget(size: 10),

          Text("Payment", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
          const GapWidget(),

          Consumer<OrderDetailProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    RadioListTile(
                      value: "pay-now",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay Now"),
                    ),
                    RadioListTile(
                      value: "pay-on-delivery",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay on Delivery"),
                    ),
                  ],
                );
              }
          ),
          const GapWidget(),
          PrimaryButton(
            onPressed: ()async{
              bool success = await BlocProvider.of<OrderCubit>(context).createOrder(
                items: BlocProvider.of<CartCubit>(context).state.items,
                paymentMethod: Provider.of<OrderDetailProvider>(context, listen: false).paymentMethod.toString(),
              );
              if(success){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context, OrderPlacedScreen.routeName);
              }
            },
              text: "Place Order")
        ],
      ),
    )
    );
  }
}
