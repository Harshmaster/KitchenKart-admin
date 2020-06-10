import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void updateStatusOnServer(String orderId, String status) async {
  String url =
      'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/orders/status/${orderId.toString()}';
  var res = await http.put(url,
      body: json.encode({"status": status}),
      headers: {"Content-Type": 'application/json'});
  Map<String, dynamic> response = await json.decode(res.body);
  print(response);
}

void updatePaymentMethod(String orderId, String paymentMethod) async {
  String url =
      'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/orders/status/${orderId.toString()}';
  var res = await http.put(url,
      body: json.encode({"paymentMethod": paymentMethod}),
      headers: {"Content-Type": 'application/json'});
  Map<String, dynamic> response = await json.decode(res.body);
  print(response);

  Firestore.instance
      .collection('OrderStatus')
      .document(
        orderId,
      )
      .updateData({'paymentMethod': paymentMethod});
}

void updateFeedBackMessage(String orderId, String message) async {
  String url =
      'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/orders/feedback/${orderId.toString()}';
  var res = await http.put(url,
      body: json.encode(
        {"feedback": message},
      ),
      headers: {"Content-Type": 'application/json'});
  Map<String, dynamic> response = await json.decode(res.body);
  print(response);
}
