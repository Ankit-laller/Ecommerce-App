import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/cubit/cart/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../core/ui.dart';
import '../cubit/cart/cart_state.dart';
import '../service/calculations.dart';
import '../service/formatter.dart';


class CartScreen extends StatefulWidget {
  static const String routeName ="CartScreen";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if(state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message.toString()),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index){
                      final item = state.items[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          width: 50,
                          imageUrl: item.product!.images![0],
                        ),
                        title: Text("${item.product?.title}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),

                            TextButton(
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).
                                removeFromCart(item.product!);
                              },
                               child: Text("Delete"),
                            ),
                          ],
                        ),
                        trailing: InputQty(
                          onQtyChanged: (value){
                            BlocProvider.of<CartCubit>(context).
                            addToCart(item.product!, value as int);
                          },
                          minVal: 1,
                          maxVal: 100,
                          initVal: item.quantity!.toInt(),
                          showMessageLimit: false,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("${state.items.length} items", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),),
                            Text("Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items))}", style: TextStyles.heading3,),

                          ],
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: CupertinoButton(
                          onPressed: () {

                          },
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
                          color: AppColors.accent,
                          child: const Text("Place Order"),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
