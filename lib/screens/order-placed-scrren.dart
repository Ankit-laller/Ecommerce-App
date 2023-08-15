import 'package:ecommerceapp/core/ui.dart';
import 'package:ecommerceapp/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});
  static const routeName = "OrderPlacedScreen";
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("order placed"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.cube_box_fill, color: AppColors.textLight,size: 100,),
            const GapWidget(size:-8),
            Text("Order Placed !", style: TextStyles.heading3.copyWith(
              color: AppColors.textLight
            ),textAlign: TextAlign.center,)
          ],
        )
      ),
    );
  }
}
