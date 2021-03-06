import 'package:http/http.dart' as http;
import 'dart:convert';

Map<String, dynamic> userList = {};
Map<String, dynamic> orderList = {};
Map<String, dynamic> details = {};

Future<void> getUserData() async {
  const url =
      'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/users/';
  try {
    await http.get(url).then((response) {
      final tempList = json.decode(response.body) as Map<String, dynamic>;
      print('work');
      userList = tempList;
    });
  } catch (err) {
    print(err);
  }
}

Future<void> getOrderData() async {
  const url =
      'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/orders';
  try {
    await http.get(url).then((response) {
      final tempList = json.decode(response.body) as Map<String, dynamic>;
      print('order working');
      orderList = tempList;
    });
  } catch (err) {
    print(err);
  }
}

Future<void> getOrderDetails(String order_id) async {
  var url = 'http://ec2-13-232-236-5.ap-south-1.compute.amazonaws.com:3000/api/order/items/${order_id}';
  try {
    await http.get(url).then((response) {
      final getdetails = json.decode(response.body) as Map<String, dynamic>;
      print('details working');
      details = getdetails; 
    });
  } catch (err) {
    print(err);
  }
}
