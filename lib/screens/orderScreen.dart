import 'package:Admin_Panel/screens/SingleOrderCardWidget.dart';
import 'package:Admin_Panel/screens/orderDetailScreen.dart';
import 'package:Admin_Panel/updateStatus.dart';
import 'package:Admin_Panel/userFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Admin_Panel/widgets/appDrawer.dart';

import '../userFunctions.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Orders',
        style: TextStyle(
          fontFamily: 'primary',
          color: Colors.black,
          fontSize: 25,
          letterSpacing: 1.5,
        ),
      ),
    );
    return Scaffold(
      appBar: appbar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/orderlist.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                  child: Text(
                    'ORDERS',
                    style: TextStyle(
                      fontFamily: 'secondary',
                      letterSpacing: 5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    (appbar.preferredSize.height +
                        MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).size.width * 0.6),
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        List.generate(orderList["response"].length, (index) {
                      return SingleOrderCard(
                        orderId: orderList["response"][index]["order_id"],
                        orderDate: orderList["response"][index]["order_date"],
                        statusOfOrder: orderList["response"][index]
                            ["status_of_order"],
                        totalAmount: orderList["response"][index]
                            ["total_amount"],
                        totalItems: orderList["response"][index]["total_items"],
                        payment: orderList["response"][index]
                            ["mode_of_payment"],
                        feedback: orderList["response"][index]["feedback"],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
