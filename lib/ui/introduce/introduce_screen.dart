import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../shared/app_drawer.dart';

import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';

enum FilterOptions { favorites, all }

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFruit'),
        actions: <Widget>[
          buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
      ),
      backgroundColor: Colors.lightGreen[100],
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Introduce Fruit shop',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                fontFamily: "DancingScript",
                color: Colors.red,
              ),
            ),
          ),
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/33/2c/da/332cdad345c68afb22a944de789621a9.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //2nd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/89/71/0e/89710e5c950e29d5ae0129d23b9c473f.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://conbuom.vn/wp-content/uploads/2021/01/mau-thiet-ke-shop-dep7.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/18/fb/9f/18fb9f463138a678614655aabe0fa3c6.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 280.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Buy fruit online from Harris Farm Markets - Sydney's premier fresh food experts. We offer premium quality at amazing prices. Our founder Dave Harris knows a good deal when he sees one and he and our team of fresh buyers hard at work sourcing your family the best quality fresh fruit and vegetables, direct from the markets and farmers daily."
              "It's simple, just select your fruit and add to cart. We then deliver to your home or office at a time slot of your choice. We offer convenient delivery windows and offer a same-day delivery service too. Give us a go today and let our expert staff hand pick your family the freshest fruit and vegetables available. You won't want to buy your fruit and veg online from the supermarkets again .. guaranteed! "
              "Not only are you getting the best and freshest fruit available, you're supporting a 100% Australian, family-owned business. Buy your groceries online and shop for fruit easily without the hassle of driving to our stores and parking - we'll actually bring your delivery to your kitchen bench! Save time and enjoy convenience like never before. We guarantee our product and know your gonna love it.",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                fontFamily: "DancingScript",
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.favorites) {
            _showOnlyFavorites.value = true;
          } else {
            _showOnlyFavorites.value = false;
          }
        });
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show All'),
        ),
      ],
    );
  }
}
