import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/oders';

  // var _isLoading = false;

  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) async {

  //   // _isLoading = true;
  //   // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });

  //   // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building orders!');
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return (Platform.isIOS
                ? Center(child: CupertinoActivityIndicator())
                : Center(child: CircularProgressIndicator()));
          } else {
            if (dataSnapshot.error != null) {
              // Error handling stuff
              return Center(
                child: Text('An error occured!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
