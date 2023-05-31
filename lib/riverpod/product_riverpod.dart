import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:spece_man/model/product_model.dart';

class ProductRiverpod extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> favorites = [];
  List<ProductModel> basketProducts = [];
  double totalPrice = 0.0;

  void setTotalPrice(ProductModel model) {
    totalPrice += model.price;
  }

  void setFavorite(ProductModel model) {
    if (model.isFavorite) {
      model.isFavorite = false;
      favorites.remove(model);
      notifyListeners();
    } else {
      model.isFavorite = true;
      favorites.add(model);
      notifyListeners();
    }
  }

  void addedBasket(ProductModel model) {
    if (model.isBasket) {
      model.isBasket = false;
      basketProducts.remove(model);
      notifyListeners();
    } else {
      model.isBasket = true;
      basketProducts.add(model);
      setTotalPrice(model);
      Grock.snackBar(
        title: "Successful",
        description: "${model.title} successfully added to cart",
        icon: Icons.check,

      );
      notifyListeners();
    }

  }

  void init() {
    for (int i = 0; i < 15; i++) {
      products.add(
        ProductModel(
          isBasket: false,
          isFavorite: false,
          title: "youphone ${i + 1}",
          description: "${8 + (i * 2)} MP camra ve 55${i * 10} mAh batary",
          price: 6000.0 + (i * 10),
          imagePath: i.randomImage(),
        ),
      );
    }
  }
}
