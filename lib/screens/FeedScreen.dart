import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/cubit/product/product_cubit.dart';
import 'package:ecommerceapp/screens/product_deail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/ui.dart';
import '../cubit/product/product_state.dart';
import '../service/formatter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {

          if(state is ProductLoadingState && state.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is ProductErrorState && state.products.isEmpty) {
            return Center(
              child: Text(state.message.toString()),
            );
          }

          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {

              final product = state.products[index];

              return CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                },
                child: Row(
                  children: [

                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 3,
                      imageUrl: "${product.images?[0] ?? ""}",
                    ),

                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${product.title}", style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
                          Text("${product.description}", style: TextStyles.body2.copyWith(color: AppColors.textLight),maxLines: 2, overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 10,),
                          Text(Formatter.formatPrice(product.price!), style: TextStyles.heading3,)
                        ],
                      ),
                    ),
                  ],
                ),
              );

            },
          );

        }
    );
  }
}
