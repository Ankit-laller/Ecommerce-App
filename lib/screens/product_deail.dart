import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/cubit/cart/cart_cubit.dart';
import 'package:ecommerceapp/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../cubit/cart/cart_state.dart';



class ProductDetailScreen extends StatefulWidget {
  static const String routeName ="ProductDetailScreen";
  final ProductModel productModel;
  const ProductDetailScreen({super.key, required this.productModel});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
              itemCount: widget.productModel.images?.length ??0,
                slideBuilder: (index){
                String url = widget.productModel.images![index];
                return CachedNetworkImage(imageUrl: url);
                },),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productModel.title.toString(), style: TextStyles.heading3,),
                const SizedBox(height: 10,),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    bool isInCart = BlocProvider.of<CartCubit>(context).cartContains(widget.productModel);
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(color: isInCart? AppColors.text
                            : AppColors.accent,
                          onPressed: () {
                        if(isInCart){
                          return;
                        }
                            BlocProvider.of<CartCubit>(context).
                            addToCart(widget.productModel, 1);
                          },child:
                      isInCart ? const Text("Added to Cart")
                        :const Text("Add to Cart"),),
                    );
                  }
                ),
                const SizedBox(height: 10,),
                Text("Description", style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),),
                Text(widget.productModel.description.toString(), style: TextStyles.body1,)
              ],
            ),
          ),


        ],
      )
    );
  }
}
