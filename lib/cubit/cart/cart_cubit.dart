

import 'dart:async';

import 'package:ecommerceapp/cubit/cart/cart_state.dart';
import 'package:ecommerceapp/cubit/user_state.dart';
import 'package:ecommerceapp/data/repository/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';
import '../user_cubit.dart';

class  CartCubit extends Cubit<CartState>{
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;

  CartCubit(this._userCubit):super(CartInitialState()){
    _handleUserState(_userCubit.state);
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }
  void _handleUserState(UserState userState){
    if(userState is UserLoggedInState){
      _initialize(userState.userModel.sId!);
    }else if(state is UserLoggedOutState){
      emit(CartInitialState());
    }
  }
  final _cartrepo = CartRepository();
  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!));
    emit( CartLoadedState(items) );
  }

  void _initialize(String userId)async{
    try{
      emit((CartLoadingState(state.items)));
      final items = await _cartrepo.fetchCartForUser(userId);
      sortAndLoad(items);
      emit(CartLoadedState(items));
    }catch(err){
      emit(CartErrorState(err.toString(), state.items));
    }
  }
  void addToCart(ProductModel product, int quantity) async {
    emit( CartLoadingState(state.items) );
    try {
      if(_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        CartItemModel newItem = CartItemModel(
            product: product,
            quantity: quantity
        );

        final items = await _cartrepo.addToCart(newItem, userState.userModel.sId!);
          userState.userModel.sId!;
          sortAndLoad(items);
          emit(CartLoadedState(items));
      }
      else {
        throw "An error occured while adding the item!";
      }
    }
    catch(ex) {
      emit( CartErrorState(ex.toString(), state.items) );
    }
  }

  void removeFromCart(ProductModel product) async {
    emit( CartLoadingState(state.items) );
    try {
      if(_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartrepo.removeFromCart(product.sId!, userState.userModel.sId!);
        userState.userModel.sId!;
        emit(CartLoadedState(items));
      }
      else {
        throw "An error occured while removing the item!";
      }
    }
    catch(ex) {
      emit( CartErrorState(ex.toString(), state.items) );
    }
  }
  bool cartContains(ProductModel product) {
    if(state.items.isNotEmpty) {
      final foundItem = state.items.where((item) => item.product!.sId! == product.sId!).toList();
      if(foundItem.isNotEmpty) {
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }
  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  void clearCart() {
    emit(CartLoadedState([]));
  }
}