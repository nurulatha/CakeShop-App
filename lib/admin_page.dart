import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<dynamic> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final url =
        Uri.parse('http://172.16.93.39/flutter_application_2/get_data.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _orders = jsonDecode(response.body);
      });
    } else {
      print('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Order List'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(order['item_name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${order['item_price']}'),
                  Text('Customer: ${order['name']}'),
                  Text('Phone: ${order['phone_number']}'),
                  Text('Address: ${order['address']}'),
                  Text('Waktu Pembelian: ${order['created_at']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
