import 'package:flutter/material.dart';
import 'package:flutter_application_2/bakery_detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<BakeryItem> items = const [
    BakeryItem(
        name: 'Chocolate Cake',
        price: 'Rp35.000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFASb_66xiP3Gc4Ucdun-wI5CwzOhSIxWS8g&s',
        description:
            'Indulge in the rich and decadent experience of a classic chocolate cake, a timeless favorite among dessert lovers. This cake features a moist, velvety texture made with high-quality cocoa powder and dark chocolate, resulting in a deep, intense flavor.'),
    BakeryItem(
      name: 'Cheese Cake',
      price: 'Rp25.000',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZLcX5NeFrqrgb6Y7XRZ4loW2X7xhlRn56Tw&s',
      description:
          'Experience the creamy and luxurious texture of a classic cheesecake, renowned for its rich and tangy flavor. This dessert begins with a buttery graham cracker crust, providing a perfect balance to the velvety filling made from a blend of cream cheese, eggs, and sugar',
    ),
    BakeryItem(
      name: 'Tiramisu Cake',
      price: 'Rp20.000',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwL5PDKeVwlAnjzda_sUlHYBb1oSzQRaSlKA&s',
      description:
          'Immerse yourself in the sophisticated flavors of a Tiramisu cake, inspired by the classic Italian dessert. This cake layers soft, coffee-soaked ladyfingers or sponge cake with a rich mascarpone cream, infused with a hint of cocoa and a touch of rum or coffee liqueur',
    ),
    BakeryItem(
      name: 'Banana Cake',
      price: 'Rp30.000',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBvFmLzUM152PDIVfeSBreZEzHpeFyHxcuug&s',
      description:
          'Savor the delightful sweetness of a banana cake, a moist and flavorful treat that captures the essence of ripe, fresh bananas. This cake combines mashed bananas with a light, fluffy batter, resulting in a rich and aromatic dessert thats both comforting and satisfying',
    ),
    BakeryItem(
        name: 'Strawberry Cake',
        price: 'Rp30.000',
        imageUrl:
            'https://preppykitchen.com/wp-content/uploads/2022/05/Strawberry-Cake-Recipe-Card-500x500.jpg',
        description:
            'Enjoy the vibrant and refreshing taste of a strawberry cake, a delightful dessert that celebrates the natural sweetness of ripe strawberries. This cake features a light and airy sponge or butter cake infused with strawberry puree, creating a subtly fruity flavor throughout'),
    BakeryItem(
        name: 'Red Velvet Cake',
        price: 'Rp30.000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0_xsol5JS-ngzdagKL1eyVb0lGiE04c67_g&s',
        description:
            'Experience the classic allure of a Red Velvet cake, a dessert known for its striking red color and rich, velvety texture. This cake is made with a unique blend of cocoa powder, buttermilk, and a touch of vinegar, giving it a subtle chocolate flavor and a tender crumb'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "https://static.vecteezy.com/system/resources/previews/016/937/046/non_2x/bakery-shop-web-banner-free-vector.jpg",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                itemBuilder: (context, index) {
                  final item = items[index];
                  return BakeryItemCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BakeryItem {
  final String name;
  final String price;
  final String imageUrl;
  final String description;

  const BakeryItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

class BakeryItemCard extends StatelessWidget {
  final BakeryItem item;

  const BakeryItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BakeryItemDetailPage(item: item),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 196, 117, 61),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.price,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
