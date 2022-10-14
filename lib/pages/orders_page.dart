import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: FutureBuilder(
          future: Provider.of<OrderList>(context, listen: false).loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Consumer<OrderList>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) {
                    return OrderWidget(order: orders.items[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
      //   body: RefreshIndicator(
      //     child: _isLoading
      //         ? const Center(
      //             child: CircularProgressIndicator(),
      //           )
      //         : ListView.builder(
      //             itemCount: orders.itemsCount,
      //             itemBuilder: (ctx, index) {
      //               return OrderWidget(order: orders.items[index]);
      //             },
      //           ),
      //     onRefresh: () => _refreshOrders(context),
      //   ),
    );
  }
}
