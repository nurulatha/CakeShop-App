import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_2/function.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  final BakeryItem item;

  const OrderPage({required this.item});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();

  String? _name, _phoneNumber;
  Position? _currentPosition;
  String? _currentAddress;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    _currentPosition = await LocationHandler.getCurrentPosition();
    _currentAddress =
        await LocationHandler.getAddressFromLatLng(_currentPosition!);

    setState(() {
      _addressController.text = _currentAddress != null
          ? '$_currentAddress, LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}'
          : '';
    });
  }

  Future<void> _submitOrder() async {
    final url = Uri.parse('http://172.16.93.39/flutter_application_2/data.php');

    final formattedPrice = widget.item.price.replaceAll(RegExp(r'[^\d]'), '');

    final response = await http.post(
      url,
      body: {
        'name': _name,
        'phone_number': _phoneNumber,
        'address': _currentAddress,
        'item_name': widget.item.name,
        'item_price': formattedPrice,
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print('Order submitted successfully');
    } else {
      print('Failed to submit order');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Color.fromARGB(255, 231, 155, 101),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 196, 117, 61),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.item.price,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.item.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSaved: (value) {
                  _currentAddress = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _phoneNumber = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Get Current Location"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 224, 206, 194),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    _submitOrder();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Order Confirmation"),
                        content: Text(
                            "Order for ${widget.item.name} placed successfully!\n\nName: $_name\nAddress: $_currentAddress\nPhone: $_phoneNumber\nItem Name: ${widget.item.name}\nItem Price: ${widget.item.price}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text("Place Order"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 147, 98),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
