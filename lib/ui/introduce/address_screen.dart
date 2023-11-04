// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:provider/provider.dart';

import '../shared/app_drawer.dart';

import '../cart/cart_manager.dart';
import '../products/top_right_badge.dart';

enum FilterOptions { favorites, all }

class MyContact extends StatefulWidget {
  const MyContact({Key? key}) : super(key: key);
  @override
  _MyContactState createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late GoogleMapController myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 10.0,
            ),
            // mapType: _currentMapType
          ),
          // Padding(
          //   padding: const EdgeInsets.all(14.0),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: FloatingActionButton(
          //       onPressed: _onMapTypeButtonPressed,
          //       materialTapTargetSize: MaterialTapTargetSize.padded,
          //       backgroundColor: Colors.green,
          //       child: const Icon(Icons.map, size: 30.0),
          //     ),
          //   ),
          // ),
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
