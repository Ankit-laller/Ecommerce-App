
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/empty-state.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EmptyState(
        path: 'assets/images/no_history.png',
        title: 'No history yet',
        description: 'Hit the blue button down below to Create an order',
        textButton: 'Start ordering',
        onClick: () {

        },

    );
  }
}
