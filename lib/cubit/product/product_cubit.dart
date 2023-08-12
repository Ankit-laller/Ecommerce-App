import 'package:ecommerceapp/cubit/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super( ProductInitialState() ) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit( ProductLoadingState(state.products) );
    try {
      final products = await _productRepository.fetchAllProducts();
      emit( ProductLoadedState(products) );
    }
    catch(ex) {
      emit( ProductErrorState(ex.toString(), state.products) );
    }
  }
}