import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/alert_page.dart'; // Ensure this import is correct
import 'package:shopping_cart/util/constants.dart';
import 'package:shopping_cart/util/details.dart';
import 'package:shopping_cart/view/landscape.dart';
import 'package:shopping_cart/view/potrait.dart';
import 'package:shopping_cart/view/tablet.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<int> counts = List<int>.filled(products.length, 1);

  void _incrementCounter(int index, ProductDetails product) {
    setState(() {
      counts[index]++;
      if (counts[index] == 5) {
        showCongratulationsAlert(context, product.title, counts[index]);
      }
    });
  }

  void _decrementCounter(int index) {
    setState(() {
      if (counts[index] > 0) {
        counts[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (int i = 0; i < products.length; i++) {
      totalPrice += int.parse(products[i].price.substring(1)) * counts[i];
    }

    Size screenSize = MediaQuery.of(context).size;
    bool isTablet = screenSize.width < 800;
    bool isPortrait = screenSize.width < 500;

    return Scaffold(
      appBar: myAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          myBag,
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                ProductDetails product = products[index];
                if (isPortrait) {
                  return PortraitMode(
                    product: product,
                    count: counts[index],
                    onIncrement: () {
                      _incrementCounter(index, product);
                    },
                    onDecrement: () {
                      _decrementCounter(index);
                    },
                  );
                } else {
                  if (isTablet) {
                    return TabletMode(
                      product: product,
                      count: counts[index],
                      onIncrement: () {
                        _incrementCounter(index, product);
                      },
                      onDecrement: () {
                        _decrementCounter(index);
                      },
                    );
                  } else {
                    return LandscapeMode(
                      product: product,
                      count: counts[index],
                      onIncrement: () {
                        _incrementCounter(index, product);
                      },
                      onDecrement: () {
                        _decrementCounter(index);
                      },
                    );
                  }
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$${totalPrice}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          checkoutElevatedButton(context),
        ],
      ),
    );
  }
}
