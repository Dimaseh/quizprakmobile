import 'package:flutter/material.dart';
import 'package:quiz_dimas/presentation/pemesanan/pemesanan_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/hotel.jpg',
      'name': 'Blue lagoon',
      'price': 500000,
    },
    {
      'image': 'assets/images/hotel.jpg',
      'name': 'Product 2',
      'price': 500000,
    },
    {
      'image': 'assets/images/hotel.jpg',
      'name': 'Blue lagoon',
      'price': 500000,
    },
    {
      'image': 'assets/images/hotel.jpg',
      'name': 'Blue lagoon',
      'price': 500000,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue Doorz'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    const url = 'https://www.traveloka.com/en-id';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 75,
                    width: 75,
                  ),
                ),
                const SizedBox(width: 16), // Jarak antara logo dan teks
                const Text(
                  'Welcome to Blue doorz',
                ),
                const Spacer(), // Ini akan membuat jarak fleksibel antara teks dan tombol
                ElevatedButton(
                  onPressed: () {
                    // Action untuk tombol about us
                  },
                  child: const Text('about us'),
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.all(8.0),
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       return SizedBox(
          //         height: 200,
          //         child: productCard(
          //           context,
          //           products[index]['image']!,
          //           products[index]['name']!,
          //           products[index]['price']!,
          //         ),
          //       );
          //     },
          //   ),
          // ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                // Passing data ke productCard
                return productCard(
                  context,
                  products[index]['image']!,
                  products[index]['name']!,
                  products[index]['price']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget productCard(BuildContext context, String imagePath, String productName,
      double productPrice) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate ke pemesanan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PemesananPage(
                      imagePath: imagePath,
                      productName: productName,
                      productPrice: productPrice,
                    ),
                  ),
                );
              },
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            productName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '\Rp$productPrice',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PemesananPage(
                    imagePath: imagePath,
                    productName: productName,
                    productPrice: productPrice,
                  ),
                ),
              );
            },
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
