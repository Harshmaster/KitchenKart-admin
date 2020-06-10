import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../updateStatus.dart';
import '../userFunctions.dart';
import 'orderDetailScreen.dart';

class SingleOrderCard extends StatefulWidget {
  final String orderId;
  final String orderDate;
  final int totalItems;
  final String statusOfOrder;
  final int totalAmount;
  final String payment;
  final String feedback;
  SingleOrderCard({
    this.orderId,
    this.orderDate,
    this.totalItems,
    this.statusOfOrder,
    this.totalAmount,
    this.payment,
    this.feedback
  });
  @override
  _SingleOrderCardState createState() => _SingleOrderCardState();
}

class _SingleOrderCardState extends State<SingleOrderCard> {
  final TextEditingController feedbackController = TextEditingController();
  String currentStatus;
  String paymentMethod;

  @override
  void initState() {
    super.initState();
    feedbackController.text = widget.feedback;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OrderDetailScreen(
              urlParam: widget.orderId,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        child: Card(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/cartAvatar.png'),
                      radius: 40,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (widget.orderId == null || widget.orderId == '')
                            ? 'Order id: No Data'
                            : 'Order id: ' + widget.orderId,
                        style: TextStyle(
                          fontFamily: 'secondary',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (widget.orderDate == null || widget.orderDate == '')
                            ? 'Order date: No Data'
                            : 'Order date: ' + widget.orderDate,
                        style: TextStyle(
                          fontFamily: 'secondary',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (widget.totalItems == null || widget.totalItems == '')
                            ? 'Total Items: No Data'
                            : 'Total Items: ' + widget.totalItems.toString(),
                        style: TextStyle(
                          fontFamily: 'secondary',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (widget.totalAmount == null || widget.totalAmount == '')
                            ? 'Total Amount: No Data'
                            : 'Total Amount: ' + widget.totalAmount.toString(),
                        style: TextStyle(
                          fontFamily: 'secondary',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        (widget.statusOfOrder == null ||
                                widget.statusOfOrder == '')
                            ? 'Order Status: No Data'
                            : 'Order Status: ' + widget.statusOfOrder,
                        style: TextStyle(
                          fontFamily: 'secondary',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Status: ',
                            style: TextStyle(
                              fontFamily: 'secondary',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width:10,),
                          DropdownButton(
                            
                            value: currentStatus,
                            hint: Text(widget.statusOfOrder),
                            items: [
                              DropdownMenuItem(
                                child: Row(
                                  children: <Widget>[
                                    Text('Order Placed'),
                                  ],
                                ),
                                value: 'order placed',
                              ),
                              DropdownMenuItem(
                                child: Row(
                                  children: <Widget>[
                                    Text('On The Way'),
                                  ],
                                ),
                                value: 'on the way',
                              ),
                              DropdownMenuItem(
                                child: Row(
                                  children: <Widget>[
                                    Text('Delivered'),
                                  ],
                                ),
                                value: 'delivered',
                              ),
                            ],
                            onChanged: (whatwaspressed) {
                              setState(() {
                                currentStatus = whatwaspressed;
                              });
                              if (whatwaspressed == 'order placed') {
                                try {
                                  Firestore.instance
                                      .collection('OrderStatus')
                                      .document(
                                        widget.orderId,
                                      )
                                      .setData({'status': 'order placed'});

                                  updateStatusOnServer(
                                      widget.orderId, 'order placed');
                                } catch (err) {
                                  print(err);
                                }
                              }
                              if (whatwaspressed == 'on the way') {
                                try {
                                  Firestore.instance
                                      .collection('OrderStatus')
                                      .document(
                                        widget.orderId,
                                      )
                                      .setData({'status': 'on the way'});

                                  updateStatusOnServer(
                                      widget.orderId, 'on the way');
                                } catch (err) {
                                  print(err);
                                }
                              }
                              if (whatwaspressed == 'delivered') {
                                try {
                                  Firestore.instance
                                      .collection('OrderStatus')
                                      .document(
                                        widget.orderId,
                                      )
                                      .setData({'status': 'delivered'});

                                  updateStatusOnServer(
                                      widget.orderId, 'delivered');
                                } catch (err) {
                                  print(err);
                                }
                              }
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Payment Method: ',
                              style: TextStyle(
                                fontFamily: 'secondary',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width:10,),
                            DropdownButton(
                              
                              hint: Text(widget.payment !=null ?widget.payment:""),
                              value: paymentMethod,
                              items: [
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text('Cash'),
                                    ],
                                  ),
                                  value: 'Cash',
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text('Google-Pay'),
                                    ],
                                  ),
                                  value: 'Google-Pay',
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text('Paytm'),
                                    ],
                                  ),
                                  value: 'Paytm',
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text('PhonePe'),
                                    ],
                                  ),
                                  value: 'PhonePe',
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    children: <Widget>[
                                      Text('Personal'),
                                    ],
                                  ),
                                  value: 'Personal',
                                ),
                              ],
                              onChanged: (whatwaspressed) {
                                setState(() {
                                  paymentMethod = whatwaspressed;
                                });
                                updatePaymentMethod(
                                    widget.orderId, whatwaspressed);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: feedbackController,
                          decoration: InputDecoration(
                            labelText: 'ENTER FEEDBACK MESSAGE',
                          ),
                          maxLines: 4,
                          minLines: 2,
                        ),
                      ),
                      RaisedButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          updateFeedBackMessage(
                              widget.orderId, feedbackController.text);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
