import 'dart:async';

import 'package:ecommerceapp/cubit/cart/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/order-model.dart';
import '../../data/repository/order-repo.dart';
import '../../service/calculations.dart';
import '../cart/cart_cubit.dart';
import '../user_cubit.dart';
import '../user_state.dart';
import 'order-state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;

  OrderCubit(this._userCubit, this._cartCubit) : super( OrderInitialState() ) {
    // initial Value
    _handleUserState(_userCubit.state);

    // Listening to User Cubit (for future updates)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if(userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    }
    else if(userState is UserLoggedOutState) {
      emit( OrderInitialState() );
    }
  }

  final _orderRepository = OrderRepository();

  void _initialize(String userId) async {
    emit( OrderLoadingState(state.orders) );
    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit( OrderLoadedState(orders) );
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
    }
  }

  Future<bool> createOrder({
    required List<CartItemModel> items,
    required String paymentMethod
  }) async {
    emit( OrderLoadingState(state.orders) );
    try {
      if(_userCubit.state is! UserLoggedInState) {
        return false;
      }

      OrderModel newOrder = OrderModel(
          items: items,
          totalAmount: Calculations.cartTotal(items),
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: (paymentMethod == "pay-on-delivery") ? "payment-pending" : "order-placed"
      );
      final order = await _orderRepository.createOrder(newOrder);

      List<OrderModel> orders = [ order, ...state.orders ];

      emit( OrderLoadedState(orders) );

      // Clear the cart
      _cartCubit.clearCart();

      return true;
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
      return false;
    }
  }
  


  Future<bool> updateOrder(OrderModel orderModel, {
    String? paymentId,
    String? signature
  }) async {
    try {
      OrderModel updatedOrder = await _orderRepository.updateOrder(
          orderModel,
          paymentId: paymentId,
          signature: signature
      );

      int index = state.orders.indexOf(updatedOrder);
      if(index == -1) return false;

      List<OrderModel> newList = state.orders;
      newList[index] = updatedOrder;

      emit( OrderLoadedState(newList) );
      return true;
    }
    catch(ex) {
      emit( OrderErrorState(ex.toString(), state.orders) );
      return false;
    }

  }


  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}