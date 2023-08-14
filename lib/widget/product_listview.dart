import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../core/ui.dart';
import '../data/models/product_model.dart';
import '../screens/product_deail.dart';
import '../service/formatter.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({
    super.key,
    required this.products
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {

        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [

              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 3,
                imageUrl: "${product.images?[0]}",
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
}