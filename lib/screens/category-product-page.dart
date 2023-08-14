import 'package:ecommerceapp/cubit/category-product/category-product-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/category-product/category-product-state.dart';
import '../widget/product_listview.dart';

class CategoryProductPage extends StatefulWidget {
  static const routeName = "CategoryProductPage";

  const CategoryProductPage({super.key});

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context, listen: true);
    return  Scaffold(
      appBar: AppBar(
        title: Text(cubit.category.title.toString()),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
          builder: (context, state) {

            if(state is CategoryProductLoadingState && state.products.isEmpty) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }

            if(state is CategoryProductErrorState && state.products.isEmpty) {
              return Center(
                child: Text(state.message),
              );
            }

            if(state is CategoryProductLoadedState && state.products.isEmpty) {
              return const Center(
                child: Text("No products found!"),
              );
            }

            return ProductListView(products: state.products);

          },
        ),
      ),
    );
  }
}
