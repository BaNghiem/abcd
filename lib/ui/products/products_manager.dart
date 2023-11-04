import '../../models/product.dart';
import 'package:flutter/foundation.dart';
import '../../models/auth_token.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  final ProductsService _productsService;
  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final saveStatus = product.isFavorite;
    product.isFavorite = !saveStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = saveStatus;
    }
  }

  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Cherry',
      description:
          'Cherry is a fruit of many plants of the genus Prunus and is a nut !',
      price: 45.00,
      imageUrl:
          'https://image.vtc.vn/files/nguyen.duc/2017/02/18/tac-dung-cherry-voi-suc-khoe-768x578-1043.jpg',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'Pineapple',
      description: 'Pineapple has spiny leaves that grow in asterisk clusters!',
      price: 20,
      imageUrl:
          'https://urbanbazaar.com.np/wp-content/uploads/2021/05/ananas-large.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Black mulberry ',
      description:
          'Black mulberry , also known as black gourd (scientific name: Morus nigra ) is a species of flowering plant in the family Moraceae',
      price: 100.01,
      imageUrl:
          'https://dalatfarm.net/wp-content/uploads/2022/04/phuc-bon-tu-den-2.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Grape',
      description: 'Grape is a berry obtained from vines of the genus Vitis .',
      price: 49.99,
      imageUrl:
          'https://media.loveitopcdn.com/1254/nho-den-khong-hat-my-nhobonmuacom-2.jpg',
      isFavorite: true,
    ),
    Product(
      id: 'p5',
      title: 'Strawberry',
      description:
          'Strawberry or simply strawberry ( scientific name : Fragaria × ananassa )is a genus of angiosperms and flowering plants in the family Roses (Rosaceae).',
      price: 49.99,
      imageUrl:
          'https://leafsie.vn/wp-content/uploads/2021/03/cac-giong-dau-tay-tren-thi-truong-viet-nam-va-the-gioi_60647e543bf76.png',
      isFavorite: true,
    ),
    Product(
      id: 'p6',
      title: 'Pomegranate',
      description:
          'Pomegranate , also known as pomegranate ( Scientific name : Punica granatum ) is a small woody fruit plant that grows to a height of 5-8 meters.',
      price: 25.99,
      imageUrl:
          'https://st1.foodsd.co.il/Images/Products/large/TENeKydcuHqGVM4e.jpg',
      isFavorite: true,
    ),
    Product(
      id: 'p7',
      title: 'Apple',
      description:
          'Some species belong to the genus Prunus , called apples in Southern dialects and plums in Northern dialects .',
      price: 33.33,
      imageUrl:
          'https://phucbinhgroup.com.vn/wp-content/uploads/2022/09/5471637_Cover.jpeg',
      isFavorite: true,
    ),
    Product(
      id: 'p8',
      title: 'Orange',
      description:
          'Oranges are the fruit of many different species of citrus trees in the family Rutaceae (see list of plants known as oranges ).',
      price: 33.33,
      imageUrl:
          'https://dacsancamvinh.net/wp-content/uploads/2015/06/cong-dung-qua-cam.jpg',
      isFavorite: true,
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  // void addProduct(Product product) {
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void updateProduct(Product product) {
  //   final index = _items.indexWhere((item) => item.id == product.id);
  //   if (index >= 0) {
  //     _items[index] = product;
  //     notifyListeners();
  //   }
  // }

  // void toggleFavoriteStatus(Product product) {
  //   final savedStatus = product.isFavorite;
  //   product.isFavorite = !savedStatus;
  // }

  // void deleteProduct(String id) {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   _items.removeAt(index);
  //   notifyListeners();
  // }
}
